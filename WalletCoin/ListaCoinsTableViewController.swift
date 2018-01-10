//
//  ViewController.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 18/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ListaCoinTableViewController: UITableViewController {
    
    let def = UserDefaults.standard
    var context : NSManagedObjectContext!
    var coins: [NSManagedObject] = []
    let formataNumero = FormataNumero()
    let bitfinexService = BitfinexService()
    let binanceService = BinanceService()
    let bitcoinTradeService = BitcoinTradeService()
    var totalLucro : Double = 0
    var investimento : Double = 0
    var quantidade : Double = 0
    var valorAtual : Double = 0
    var repeating: Timer?
    let cc = CriaCoins()
    var buffer = Buffer()
    var viewInvestimentoTotal : Double = 0
    var viewLucroTotal : Double = 0
    
    @IBOutlet weak var lblViewPorcentagem: UILabel!
    @IBOutlet weak var lblViewLucroTotal: UILabel!
    @IBOutlet weak var lblViewInvestimentoTotal: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atualizaCoins()
        repeating = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(atualizaCoins), userInfo: nil, repeats: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        //self.deleteAllData(entity: "Coin")
        //self.deleteAllData(entity: "Compra")
        //soh cria as coins uma vez
        if def.bool(forKey: "firstRun") { cc.criaCoins(context: context) }
        //cc.criaCoins(context: context)
        //cc.addCoin(context: context)
        
        
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
    
    @objc func atualizaCoins(){
        for coin in coins{
            let nome = coin.value(forKey: "nome") as? String
            
            _ = self.binanceService.binanceTradeBitcoin(buffer: buffer)
            if nome == "Bitcoin"{
                self.bitcoinTradeService.bitcoinTrade(nomeMoeda: nome!, qtd: self.quantidade, investimento: self.investimento, buffer: buffer)
            }else if nome == "Tron" || nome == "Dent"{
                if let urlMoeda = coin.value(forKey: "urlSymbol"){
                    self.binanceService.binanceTrade(nomeMoeda: nome!, moeda: String(describing: urlMoeda), cqtd: self.quantidade, investimento: self.investimento, buffer: buffer)
                }
            }else{
                if let urlMoeda = coin.value(forKey: "urlSymbol"){
                    self.bitfinexService.bitfinexTrade(nomeMoeda: nome!, moeda: String(describing: urlMoeda), cqtd: self.quantidade, investimento: self.investimento, buffer: buffer)
                }
            }
            
            quantidade = coin.value(forKey: "qtd") as! Double
            investimento = coin.value(forKey: "investimento") as! Double
            
            
            let preco = buffer.meuBuffer[nome!]
            let totalLucro = (quantidade * preco!)

            coin.setValue(totalLucro, forKey: "totalLucro")
            
            if nome != "Bitcoin"{
                viewInvestimentoTotal += investimento
                viewLucroTotal += totalLucro
            }
            
            var porcentagem = 0.0
            if investimento != 0{
                porcentagem = ((totalLucro/investimento) - 1)*100
            }
            coin.setValue(porcentagem, forKey: "porcentagem")
            
            do{
                try context.save()
            } catch {
                print("Erroa o salvar as coins")
            }
            
        }
        
            lblViewInvestimentoTotal.text = "$" + formataNumero.formataPreco(preco: viewInvestimentoTotal as! NSNumber)
            lblViewLucroTotal.text = "$" +  formataNumero.formataPreco(preco: viewLucroTotal as NSNumber)
            let porcentagemTotal : Double = ((viewLucroTotal/viewInvestimentoTotal) - 1)*100
            lblViewPorcentagem.text = formataNumero.formataPorcentagem(val: porcentagemTotal as NSNumber)
            if porcentagemTotal >= 0{
                lblViewPorcentagem.textColor = UIColor(red: 0, green: 0.6, blue:0, alpha: 1.0)
            } else{
                lblViewPorcentagem.textColor = UIColor.red
            }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row <= 1){
            viewLucroTotal = 0
            viewInvestimentoTotal = 0
        }
        let coin = coins[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaCoin", for: indexPath) as! CoinTableViewCell
        
        let nome = coin.value(forKey: "nome") as? String
        celula.lblNomeMoeda.text = nome
        
        celula.lblSigla.text = coin.value(forKey: "sigla") as? String
        
        let imagem: Data = coin.value(forKey: "logo") as! Data
        celula.imgLogo.image = UIImage(data: imagem)
        
        let qtd = coin.value(forKey: "qtd") as! Double
        if nome == "Bitcoin"{
            celula.lblQtdDeMoedas.text = formataNumero.formataQuantidadeBitcoin(qtd: qtd as! NSNumber)
        }else{
            celula.lblQtdDeMoedas.text = formataNumero.formataQuantidadeCoin(qtd: qtd as! NSNumber)
        }
        
        
        if let invest = coin.value(forKey: "investimento") {
            celula.lblInvestimentoMedio.text = formataNumero.formataPreco(preco: invest as! NSNumber)
        }
        
        let preco = buffer.meuBuffer[nome!]
        celula.lblValorAtual.text = self.formataNumero.formataPreco(preco: preco! as NSNumber)
        
        if let totalLucro = coin.value(forKey: "totalLucro"){
            celula.lblTotal.text = self.formataNumero.formataPreco(preco: totalLucro as! NSNumber)
        }
        
        
        if let porcentagem = coin.value(forKey: "porcentagem") as? Double{
            celula.lblPorcentagem.text = self.formataNumero.formataPorcentagem(val: porcentagem as NSNumber)
        
            if porcentagem >= 0{
                celula.lblPorcentagem.textColor = UIColor(red: 0, green: 0.6, blue:0, alpha: 1.0)
            } else{
                celula.lblPorcentagem.textColor = UIColor.red
            }
        }
        
        return celula
    }
    
    //alerta de limites
    /*func verificaLimites(porcentagem: Double, nomeMoeda: String){
        
        let storyboard: UIStoryboard =
            UIStoryboard.init(name: "Main",bundle: nil);
        
        let limitesViewController:
            LimitesViewController = storyboard.instantiateViewController(withIdentifier: "Main") as! LimitesViewController;

        let limites = limitesViewController.getLimites()
        
        
        if limites.limiteSuperior >= porcentagem{
            let notification = UNMutableNotificationContent()
            notification.title = "Alerta variação positiva!"
            notification.subtitle = nomeMoeda + "em alta!"
            notification.body = "O lucro obtido com " + nomeMoeda + "ultrapassou o limite superior estabelecido nas configurações"
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        if limites.limiteInferior <= porcentagem{
            let notification = UNMutableNotificationContent()
            notification.title = "Alerta variação negativa!"
            notification.subtitle = nomeMoeda + "em baixa!"
            notification.body = "O lucro obtido com " + nomeMoeda + "ultrapassou o limite inferior estabelecido nas configurações"
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "notification2", content: notification, trigger: notificationTrigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }*/
    
    
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

