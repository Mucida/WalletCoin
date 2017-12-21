//
//  Compra.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 18/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit


class CompraDAO{
    
    var coin : Moeda!
    var qtd : Double! //quantidade da moeda que foi comprada
    var valorDaMoedaEmBitcoin : Double! //valor em bitcoin de cada unidade da moeda na hora da compra
    var valorDoBitcoin : Double! //valor em dolar do bitcoin no momento da compra da moeda em questão
    var data : Date! //data da compra
    
    init(coin: Moeda, qtd: Double, valorMoeda: Double, valorBitcoin: Double, data: Date){
        self.coin = coin
        self.qtd = qtd
        self.valorDaMoedaEmBitcoin = valorMoeda
        self.valorDoBitcoin = valorBitcoin
        self.data = data
    }
    
}

