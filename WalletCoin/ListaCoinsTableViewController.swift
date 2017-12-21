//
//  ViewController.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 18/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit
import CoreData

class ListaCoinTableViewController: UITableViewController {
    
    let def = UserDefaults.standard
    var context : NSManagedObjectContext!
    var coins: [NSManagedObject] = []
    let formataNumero = FormataNumero()
    let bitfinexService = BitfinexService()
    let bitcoinTradeService = BitcoinTradeService()
    var totalLucro : Double = 0
    var investimento : Double = 0
    var quantidade : Double = 0
    var valorAtual : Double = 0
    var repeating: Timer?
    let cc = CriaCoins()
    var buffer = Buffer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repeating = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(atualiza), userInfo: nil, repeats: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        //self.deleteAllData(entity: "Coin")
        //self.deleteAllData(entity: "Compra")
        //soh cria as coins uma vez
        if def.bool(forKey: "firstRun") { cc.criaCoins(context: context) }
        //cc.criaCoins(context: context)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func atualiza(){
        self.tableView.reloadData()
    }
    
    
    func buscaCoinPorCoin(){
        var requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Coin")
        do {
            requisicao.predicate = NSPredicate(format: "emUso == %@", NSNumber(value: true))
            let sort = NSSortDescriptor(key: #keyPath(Coin.nome), ascending: true)
            requisicao.sortDescriptors = [sort]
            let coinsRecuperadas = try context.fetch(requisicao)
            self.coins = coinsRecuperadas as! [NSManagedObject]
            self.tableView.reloadData()
        } catch let erro as NSError{
            print("Erro: \(erro.description)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        buscaCoinPorCoin()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(self.coins.count))
        return self.coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = coins[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaCoin", for: indexPath) as! CoinTableViewCell
        
        let nome = coin.value(forKey: "nome") as? String
        celula.lblNomeMoeda.text = nome
        celula.lblSigla.text = coin.value(forKey: "sigla") as? String
        let imagem: Data = coin.value(forKey: "logo") as! Data
        celula.imgLogo.image = UIImage(data: imagem)
        quantidade = coin.value(forKey: "qtd") as! Double
        celula.lblQtdDeMoedas.text = formataNumero.formataQuantidadeBitcoin(qtd: quantidade as! NSNumber)
        investimento = coin.value(forKey: "investimento") as! Double
        celula.lblInvestimentoMedio.text = formataNumero.formataPreco(preco: investimento as! NSNumber)
        
        
        if nome == "Bitcoin"{
            self.bitcoinTradeService.bitcoinTrade(nomeMoeda: nome!, qtd: self.quantidade, investimento: self.investimento, buffer: buffer)
        }else{
            if let urlMoeda = coin.value(forKey: "urlSymbol"){
                self.bitfinexService.bitfinexTrade(nomeMoeda: nome!, moeda: String(describing: urlMoeda), cqtd: self.quantidade, investimento: self.investimento, buffer: buffer)
                
            }
        }
        
        let preco = buffer.meuBuffer[nome!]
        celula.lblValorAtual.text = self.formataNumero.formataPreco(preco: preco as! NSNumber)
        
        var totalLucro = (quantidade * preco!)
        celula.lblTotal.text = self.formataNumero.formataPreco(preco: totalLucro as NSNumber)
        
        var porcentagem = 0.0
        if investimento != 0{
            porcentagem = ((totalLucro/investimento) - 1)*100
        }
        celula.lblPorcentagem.text = self.formataNumero.formataPorcentagem(val: porcentagem as NSNumber)
        if porcentagem >= 0{                                        celula.lblPorcentagem.textColor = UIColor.green
        } else{
            celula.lblPorcentagem.textColor = UIColor.red
        }
        
        
        
        
        return celula
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toCompraTable"){
            if let indexPath = tableView.indexPathForSelectedRow {
                let coinSelecionado = self.coins[indexPath.row]
                let viewControllerDestino = segue.destination as! ComprasTableViewController
                viewControllerDestino.coin = coinSelecionado
            }
        }
    }
    
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: "toSeleciona", sender: self)
    }
    
    func deleteAllData(entity: String)
    {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    
    
}

