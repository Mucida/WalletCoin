//
//  FormataNumero.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 20/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit

class FormataNumero{
    
    let nf = NumberFormatter()
    
    func formataPreco(preco: NSNumber) -> String{
        
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco) {
            return precoFinal
        }
        return "0.00"
    }
    
    func formataQuantidadeBitcoin(qtd: NSNumber) -> String{
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 8
        nf.maximumFractionDigits = 8
        if let qtdFinal = nf.string(from: qtd) {
            return qtdFinal
        }
        return "0.00"
    }
    
    func formataQuantidadeCoin(qtd: NSNumber) -> String{
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        if let qtdFinal = nf.string(from: qtd) {
            return qtdFinal
        }
        return "0.00"
    }
    
    func formataPorcentagem(val: NSNumber) -> String{
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        
        if let porcentagem = nf.string(from: val) {
            let porcentagemFinal : String = porcentagem + "%"
            return porcentagemFinal
        }
        return "0.0%"
    }
    
    
    func formataPrecoEditado(preco: NSNumber) -> String{
        nf.decimalSeparator = "."
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        
        if let precoFinal = nf.string(from: preco) {
            return precoFinal
        }
        return "0.00"
    }
    
    func formataQuantidadeBitcoinEditado(qtd: NSNumber) -> String{
        nf.decimalSeparator = "."
        nf.minimumFractionDigits = 8
        nf.maximumFractionDigits = 8
        if let qtdFinal = nf.string(from: qtd) {
            return qtdFinal
        }
        return "0.00"
    }
    
    func formataQuantidadeCoinEditado(qtd: NSNumber) -> String{
        nf.decimalSeparator = "."
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        if let qtdFinal = nf.string(from: qtd) {
            return qtdFinal
        }
        return "0.00"
    }
    
}
