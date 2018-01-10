//
//  BinanceService.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 09/01/18.
//  Copyright © 2018 Lucas Mucida Costa. All rights reserved.
//

import Foundation
//
//  BitfinexService.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 20/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit

class BinanceService{
    
    var valorCoinAtual : Double = 0
    let formataNumero = FormataNumero()
    
    func binanceTrade(nomeMoeda: String, moeda: String, cqtd: Double, investimento: Double, buffer: Buffer){
        
        let urlString = "https://api.binance.com/api/v1/ticker/24hr?symbol=" + moeda
        print(urlString)
        if let url = URL(string: urlString) {
            
            _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                guard let data = data else { return }
                //print(data)
                //Implement JSON decoding and parsing
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    if let respostaJsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                            if let precoAtualCoin = respostaJsonData["lastPrice"] as? String{
                                print(precoAtualCoin)
                                //nao atualiza nadae enqaunto nao carrega
                                DispatchQueue.main.async(execute: {
                                    buffer.meuBuffer[nomeMoeda] = Double(precoAtualCoin)! * buffer.meuBuffer["BitcoinDolar"]!
                                    print("precoDoBitcoin: " + String(describing: buffer.meuBuffer["BitcoinDolar"]))
                                    print("precoAtualCoin: " + nomeMoeda + " --- " + precoAtualCoin)
                                })
                            }
                    }
                }
                catch let jsonError {
                    print(jsonError)
                }
                
                }.resume()
            
        }
    }
        
        func binanceTradeBitcoin(buffer: Buffer)->String{
            
            let urlString = "https://api.binance.com/api/v1/ticker/24hr?symbol=BTCUSDT"
            print(urlString)
            var precoBitcoin : String = "0"
            if let url = URL(string: urlString) {
                
                _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    guard let data = data else { return }
                    //print(data)
                    //Implement JSON decoding and parsing
                    do {
                        //Decode retrived data with JSONDecoder and assing type of Article object
                        if let respostaJsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                            if let precoAtualBitcoinCoin = respostaJsonData["lastPrice"] as? String{
                                print("precoAtualBitcoinCoin: " + precoAtualBitcoinCoin)
                                //nao atualiza nadae enqaunto nao carrega
                                DispatchQueue.main.async(execute: {
                                   buffer.meuBuffer["BitcoinDolar"] = Double(precoAtualBitcoinCoin)!
                                })
                            }
                        }
                    }
                    catch let jsonError {
                        print(jsonError)
                    }
                    
                    }.resume()
                
            }
            return precoBitcoin
    }
    
    //func buscaValor(moeda: String) -> Double{
    // bitcoinTrade(moeda: moeda)
    //return valorCoinAtual
    //}
    
}
