//
//  BitfinexService.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 20/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit

class BitfinexService{
    
    var valorCoinAtual : Double = 0
    let formataNumero = FormataNumero()
    
    func bitfinexTrade(nomeMoeda: String, moeda: String, cqtd: Double, investimento: Double, buffer: Buffer){
        
        let urlString = "https://api.bitfinex.com/v1/trades/" + moeda
        print(urlString)
        if let url = URL(string: urlString) {
            
            _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                    guard let data = data else { return }
                    //Implement JSON decoding and parsing
                    do {
                        //Decode retrived data with JSONDecoder and assing type of Article object
                        if let respostaJsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                            if let coin = respostaJsonData[0] as? [String : Any]{
                                if let precoAtualCoin = coin["price"] as? String{
                                    //nao atualiza nadae enqaunto nao carrega
                                    DispatchQueue.main.async(execute: {
                                        buffer.meuBuffer[nomeMoeda] = Double(precoAtualCoin)!
                                    })
                                }
                            }
                        }
                    }
                    catch let jsonError {
                        print(jsonError)
                    }

                }.resume()
            
        }
    }
    
    //func buscaValor(moeda: String) -> Double{
    // bitcoinTrade(moeda: moeda)
    //return valorCoinAtual
    //}
    
}
