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
    var compraEditada : NSManagedObject!
    var qtdGuardada : Double = 0
    let formataNumero = FormataNumero()
    var investimentoGuardado : Double = 0
    var unitarioGuardado : Double  = 0
    var bitGuardado : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        lblSigla.text = coin.value(forKey: "sigla") as! String
        let imagem: Data = coin.value(forKey: "logo") as! Data
        imgLogo.image = UIImage(data: imagem)
        let nome = coin.value(forKey: "nome") as! String
        if(nome ==  "Bitcoin"){
            txtValorUnitario.text = "1"
            txtValorUnitario.isEnabled = false
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        if let compra = compraEditada{
            carregaCompraEditada(nome: nome)
        }
    }
    
    //carrega nos campos e guarda os valores da compra antes da ediçao
    func carregaCompraEditada(nome: String){
        if let qtd = compraEditada.value(forKey: "qtd") as? Double{
            qtdGuardada = qtd
            txtQtd.text = formataNumero.formataQuantidadeCoin(qtd: qtd as NSNumber)
        }
        if let unitario = compraEditada.value(forKey: "valorUnitario") as? Double{
            unitarioGuardado = unitario
            if nome != "Bitcoin"{
                txtValorUnitario.text = formataNumero.formataQuantidadeBitcoin(qtd: unitario as NSNumber)
            }
        }
        if let bit = compraEditada.value(forKey: "valorBitcoin") as? Double{
            bitGuardado = bit
            txtValorBitcoin.text = formataNumero.formataPreco(preco: bit as NSNumber)
        }
        investimentoGuardado = qtdGuardada*unitarioGuardado*bitGuardado
        if let dataEditada = compraEditada.value(forKey: "data") as? Date{
            dataCompra.date = dataEditada
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //verifica se algum campo de texto está vazio antes de ocnfirmar a compra
    func validaCampos() -> Bool{
        var qtdBool : Bool = true
        var unitarioBool : Bool = true
        var bitcoinBool : Bool = true
        if let _textqtd = txtQtd.text, _textqtd.isEmpty {
            qtdBool = false
        }
        if let _textunitario = txtValorUnitario.text, _textunitario.isEmpty {
            unitarioBool = false
        }
        if let _textbit = txtValorBitcoin.text, _textbit.isEmpty {
            bitcoinBool = false
        }
        
        if qtdBool == true && unitarioBool == true && bitcoinBool == true{
            return true
        }else{
            return false
        }
    }
    
    @IBAction func btnConfirmar(_ sender: Any) {
        if !validaCampos(){
            let alert = UIAlertController(title: "Campo Vazio", message: "Todos os campos devem ser preenchidos", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            if compraEditada == nil{
                let compra = NSEntityDescription.insertNewObject(forEntityName: "Compra", into: context)
                salvaCompra(compra: compra)
            }else{
                salvaCompraEditada(compra: compraEditada)
            }
        }
    }
    
    func salvaCompra(compra: NSManagedObject){
        
        var qtdC:Double=0
        var valorUnitarioC:Double=0
        var valorBitcoinC:Double=0
        let nome = coin.value(forKey: "nome") as! String
        
        print(self.txtQtd.text)
        
        if let qtd = self.txtQtd.text{
            qtdC = Double(qtd)!
            compra.setValue(qtdC, forKey: "qtd")
        }
        if nome == "Bitcoin"{
            valorUnitarioC = 1
            txtValorUnitario.isEnabled = false
            txtValorUnitario.text = "1"
             compra.setValue(valorUnitarioC, forKey: "valorUnitario")
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
    
    func salvaCompraEditada(compra: NSManagedObject){
        
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
            compra.setValue(valorUnitarioC, forKey: "valorUnitario")
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
        
        let quatidadeAnterior = coin.value(forKey: "qtd") as? Double
        let totalArmazenado = coin.value(forKey: "investimento") as? Double
        
        //calculo do total investido na moeda (soma de todas as compras)
        let totalInvestido = qtdC*valorUnitarioC*valorBitcoinC
        
        let total = totalArmazenado! + totalInvestido - investimentoGuardado
        coin.setValue(total, forKey: "investimento")
        
        //calculo do total de moeda compradas ate agora
        
        let totalQtd = quatidadeAnterior! + qtdC - qtdGuardada
        coin.setValue(totalQtd, forKey: "qtd")
        
        do{
            try context.save()
        } catch {
            print("Erroa o salvar a compra")
        }
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    
}
