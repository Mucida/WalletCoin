//
//  Moeda.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 18/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit


class Moeda{
    
     var emUso: Bool = false
     var nome : String!
     var sigla : String!
     var logo : UIImage!
     var qtdAtual : Double = 0
     var valorAtual : Double = 0
    
    init(nome: String, sigla: String, logo: UIImage){
        self.nome = nome
        self.sigla = sigla
        self.logo = logo
    }
}
