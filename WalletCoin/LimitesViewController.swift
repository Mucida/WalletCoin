//
//  LimitesViewController.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 22/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit

class LimitesViewController: UIViewController {

    @IBOutlet weak var txtLimiteSuperior: UITextField!
    @IBOutlet weak var txtLimiteInferior: UITextField!
    var limites = Limite(limiteSuperior: 0, limiteInferior: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnAplicar(_ sender: Any) {
        
        if let limiteSuperior = txtLimiteSuperior.text{
            limites.limiteSuperior = Double(limiteSuperior)!
        }
        if let limiteInferior = txtLimiteInferior.text{
            limites.limiteInferior = Double(limiteInferior)!
        }
        
    }
    
    func getLimites() -> Limite{
        return self.limites
    }
    
}
