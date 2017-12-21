//
//  BitcoinTradeService.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 20/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit
import Foundation


class BitcoinTradeService{
    
    var valorBitCoinAtual : Double = 0
    let formataNumero = FormataNumero()
    
    func bitcoinTrade(nomeMoeda: String, qtd: Double, investimento: Double, buffer: Buffer){
        
        let urlString = "https://api.bitcointrade.com.br/v1/public/BTC/ticker"
        if let url = URL(string: urlString) {
            
            let tarefa = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                //Implement JSON decoding and parsing
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    if let respostaJsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String :  Any] {
                        if let dadosCoin = respostaJsonData["data"] as? [String : Any]{
                            if let precoAtualBitCoin = dadosCoin["last"] as? Double{
                                //nao atualiza nadae enqaunto nao carrega
                                DispatchQueue.main.async(execute: {
                                   buffer.meuBuffer[nomeMoeda] = precoAtualBitCoin
                                })
                            }
                        }
                        
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                }.resume()
        }
 
    }
    
    //func buscaValor() -> Double{
        //bitcoinTrade()
        //return valorBitCoinAtual
    //}
    
}
