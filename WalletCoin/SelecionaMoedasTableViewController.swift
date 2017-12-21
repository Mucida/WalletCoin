//
//  SelecionaMoedasTableViewController.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 20/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit
import CoreData

class SelecionaMoedasTableViewController: UITableViewController {

    var coins: [NSManagedObject] = []
    var context : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        do{
            var requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Coin")
            let sort = NSSortDescriptor(key: #keyPath(Coin.nome), ascending: true)
            requisicao.sortDescriptors = [sort]
            let coinsRecuperadas = try context.fetch(requisicao)
            self.coins = coinsRecuperadas as! [NSManagedObject]
        }catch let erro as NSError{
            print("Erro: \(erro.description)")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = coins[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaSeleciona", for: indexPath) as! CelulaSelecionaTableViewCell
    
        let imagem: Data = coin.value(forKey: "logo") as! Data
        celula.lblImagem.image = UIImage(data: imagem)
        let nome = coin.value(forKey: "nome") as? String
        celula.lblNome.text = nome
        
        let emUso = coin.value(forKey: "emUso") as! Bool
        if(emUso){
            celula.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
             celula.accessoryType = UITableViewCellAccessoryType.none
        }
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]

        if(tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            atualizar(coin: coin, uso: false)
            
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            atualizar(coin: coin, uso: true)
        }
        
    }
    
    func atualizar(coin: NSManagedObject, uso: Bool){
        coin.setValue(uso, forKey: "emUso")
        
        do{
            try context.save()
        }catch {
            print("Erroa o salvar as em uso")
        }
    }
    
}
