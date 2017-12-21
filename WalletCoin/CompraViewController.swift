//
//  CompraViewController.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 18/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit
import CoreData



class CompraViewController: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblSigla: UILabel!
    @IBOutlet weak var txtQtd: UITextField!
    @IBOutlet weak var txtValorUnitario: UITextField!
    @IBOutlet weak var txtValorBitcoin: UITextField!
    @IBOutlet weak var dataCompra: UIDatePicker!
    var context : NSManagedObjectContext!
    var coin : NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        lblSigla.text = coin.value(forKey: "sigla") as! String
        let imagem: Data = coin.value(forKey: "logo") as! Data
        imgLogo.image = UIImage(data: imagem)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnConfirmar(_ sender: Any) {
        let compra = NSEntityDescription.insertNewObject(forEntityName: "Compra", into: context)
        var qtdC:Double=0
        var valorUnitarioC:Double=0
        var valorBitcoinC:Double=0
        let nome = coin.value(forKey: "nome") as! String
        
        
        if let qtd = self.txtQtd.text {
            qtdC = Double(qtd)!
            compra.setValue(Double(qtd), forKey: "qtd")
        }
        if nome == "Bitcoin"{
            valorUnitarioC = 1
            txtValorUnitario.isEnabled = false
            txtValorUnitario.text = "1"
        }else{
            if let valorUnitario = self.txtValorUnitario.text{
                valorUnitarioC = Double(valorUnitario)!
                compra.setValue(Double(valorUnitario), forKey: "valorUnitario")
                txtValorUnitario.isEnabled = true
            }
        }
        if let valorBitcoin = self.txtValorBitcoin.text{
            valorBitcoinC = Double(valorBitcoin)!
            compra.setValue(Double(valorBitcoin), forKey: "valorBitcoin")
        }
        compra.setValue(dataCompra.date, forKey: "data")
        compra.setValue(coin, forKey: "relCoin")
        
        //calculo do total investido na moeda (soma de todas as compras)
        let totalInvestido = qtdC*valorUnitarioC*valorBitcoinC
        let totalArmazenado = coin.value(forKey: "investimento") as? Double
        let total = totalArmazenado! + totalInvestido
        coin.setValue(total, forKey: "investimento")
        
        //calculo do total de moeda compradas ate agora
        let quatidadeAnterior = coin.value(forKey: "qtd") as? Double
        let totalQtd = quatidadeAnterior! + qtdC
        coin.setValue(totalQtd, forKey: "qtd")
        
        do{
            try context.save()
        } catch {
            print("Erroa o salvar a compra")
        }
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
}
