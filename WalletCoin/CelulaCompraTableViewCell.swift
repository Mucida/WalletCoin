//
//  CelulaCompraTableViewCell.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 18/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit

class CelulaCompraTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblSigla: UILabel!
    @IBOutlet weak var lblQtd: UILabel!
    @IBOutlet weak var lblPreco: UILabel!
    @IBOutlet weak var lblBitcoin: UILabel!
    @IBOutlet weak var lblDataCompra: UILabel!
    
}
