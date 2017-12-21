//
//  ComprasTableViewController.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 18/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import UserNotifications



class ComprasTableViewController: UITableViewController {

    var compras: [NSManagedObject] = []
    let formataNumero = FormataNumero()
    let def = UserDefaults.standard
    var context : NSManagedObjectContext!
    var coin : NSManagedObject!
    var fetchedResultsController : NSFetchedResultsController<Coin>!
    var totalInvestido : Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        
    }
    override func viewDidAppear(_ animated: Bool) {
        buscaCompras()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    func buscaCompras(){
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Compra")
        do {
            let teste = coin.value(forKey: "nome")
            print(teste)
            requisicao.predicate = NSPredicate(format: "relCoin.nome = %@", coin.value(forKey: "nome") as! CVarArg)
            let comprasRecuperadas = try context.fetch(requisicao)
            self.compras = comprasRecuperadas as! [NSManagedObject]
            self.tableView.reloadData()
        } catch let erro as NSError{
            print("Erro: \(erro.description)")
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(self.compras.count))
        return self.compras.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let compra = compras[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaCompra", for: indexPath) as! CelulaCompraTableViewCell
        
        let imagem: Data = coin.value(forKey: "logo") as! Data
        celula.imgLogo.image = UIImage(data: imagem)
        celula.lblSigla.text = coin.value(forKey: "sigla") as? String
        if let qtd = compra.value(forKey: "qtd") {
            celula.lblQtd.text = String(describing: qtd)
        }
        if let preco = compra.value(forKey: "valorUnitario"){
            celula.lblPreco.text =  formataNumero.formataQuantidadeBitcoin(qtd: preco as! NSNumber)
        }
        if let bitcoin = compra.value(forKey: "valorBitcoin"){
            celula.lblBitcoin.text = formataNumero.formataPreco(preco: bitcoin as! NSNumber)
        }
        
        let formatacaoData = DateFormatter()
        formatacaoData.dateFormat =  "dd/MM/yyy hh:mm a"
        formatacaoData.amSymbol = "AM"
        formatacaoData.pmSymbol = "PM"
        let data = compra.value(forKey: "data") as! Date
        celula.lblDataCompra.text = formatacaoData.string(from: data)
        
        return celula
    }
    

    @IBAction func adicionar(_ sender: Any) {
        performSegue(withIdentifier: "toCompra", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toCompra"){
            let viewControllerDestino = segue.destination as! CompraViewController
            viewControllerDestino.coin = coin;
        }
    }

}
