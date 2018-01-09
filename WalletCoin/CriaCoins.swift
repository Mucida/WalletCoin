//
//  CriaCoins.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 20/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//

import UIKit
import CoreData

class CriaCoins{
    
    let def = UserDefaults.standard
    
    func criaCoins(context: NSManagedObjectContext){
        
        let bitcoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        bitcoin.setValue("Bitcoin", forKey: "nome")
        bitcoin.setValue("BTC", forKey: "sigla")
        let imageData: NSData = UIImagePNGRepresentation(#imageLiteral(resourceName: "BTC"))! as NSData
        bitcoin.setValue(imageData, forKey: "logo")
        
        let litecoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        litecoin.setValue("Litecoin", forKey: "nome")
        litecoin.setValue("LTC", forKey: "sigla")
        let imageData2 = UIImagePNGRepresentation(#imageLiteral(resourceName: "LTC"))! as NSData
        litecoin.setValue(imageData2, forKey: "logo")
        litecoin.setValue("ltcusd", forKey: "urlSymbol")
        
        let ethereumCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        ethereumCoin.setValue("Ethereum", forKey: "nome")
        ethereumCoin.setValue("ETH", forKey: "sigla")
        let imageData3 = UIImagePNGRepresentation(#imageLiteral(resourceName: "ETH"))! as NSData
        ethereumCoin.setValue(imageData3, forKey: "logo")
        ethereumCoin.setValue("ethusd", forKey: "urlSymbol")
        
        let ethereumClassicCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        ethereumClassicCoin.setValue("Ethereum Classic", forKey: "nome")
        ethereumClassicCoin.setValue("ETC", forKey: "sigla")
        let imageData4 = UIImagePNGRepresentation(#imageLiteral(resourceName: "ETC"))! as NSData
        ethereumClassicCoin.setValue(imageData4, forKey: "logo")
        ethereumClassicCoin.setValue("etcusd", forKey: "urlSymbol")
        
        let zCashCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        zCashCoin.setValue("Zcash", forKey: "nome")
        zCashCoin.setValue("ZEC", forKey: "sigla")
        let imageData5 = UIImagePNGRepresentation(#imageLiteral(resourceName: "ZEC-alt"))! as NSData
        zCashCoin.setValue(imageData5, forKey: "logo")
        zCashCoin.setValue("zecusd", forKey: "urlSymbol")
        
        let moneroCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        moneroCoin.setValue("Monero", forKey: "nome")
        moneroCoin.setValue("XMR", forKey: "sigla")
        let imageData6 = UIImagePNGRepresentation(#imageLiteral(resourceName: "ZEC-alt"))! as NSData
        moneroCoin.setValue(imageData6, forKey: "logo")
        moneroCoin.setValue("xmrusd", forKey: "urlSymbol")
        
        let dashCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        dashCoin.setValue("Dash", forKey: "nome")
        dashCoin.setValue("DASH", forKey: "sigla")
        let imageData7 = UIImagePNGRepresentation(#imageLiteral(resourceName: "DASH"))! as NSData
        dashCoin.setValue(imageData7, forKey: "logo")
        dashCoin.setValue("dshusd", forKey: "urlSymbol")
        
        let rippleCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        rippleCoin.setValue("Ripple", forKey: "nome")
        rippleCoin.setValue("XRP", forKey: "sigla")
        let imageData8 = UIImagePNGRepresentation(#imageLiteral(resourceName: "ripple"))! as NSData
        rippleCoin.setValue(imageData8, forKey: "logo")
        rippleCoin.setValue("xrpusd", forKey: "urlSymbol")
        
        let iotaCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        iotaCoin.setValue("IOTA", forKey: "nome")
        iotaCoin.setValue("IOTA", forKey: "sigla")
        let imageData9 = UIImagePNGRepresentation(#imageLiteral(resourceName: "IOTA-alt"))! as NSData
        iotaCoin.setValue(imageData9, forKey: "logo")
        iotaCoin.setValue("iotusd", forKey: "urlSymbol")
        
        let eosCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        eosCoin.setValue("EOS", forKey: "nome")
        eosCoin.setValue("EOS", forKey: "sigla")
        let imageData10 = UIImagePNGRepresentation(#imageLiteral(resourceName: "EOS-alt"))! as NSData
        eosCoin.setValue(imageData10, forKey: "logo")
        eosCoin.setValue("eosusd", forKey: "urlSymbol")
        
        let santimentCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        santimentCoin.setValue("Santiment", forKey: "nome")
        santimentCoin.setValue("SAN", forKey: "sigla")
        let imageData11 = UIImagePNGRepresentation(#imageLiteral(resourceName: "sant3"))! as NSData
        santimentCoin.setValue(imageData11, forKey: "logo")
        santimentCoin.setValue("sanusd", forKey: "urlSymbol")
        
        let omiseCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        omiseCoin.setValue("OmiseGO", forKey: "nome")
        omiseCoin.setValue("OMG", forKey: "sigla")
        let imageData12 = UIImagePNGRepresentation(#imageLiteral(resourceName: "OMG-alt"))! as NSData
        omiseCoin.setValue(imageData12, forKey: "logo")
        omiseCoin.setValue("omgusd", forKey: "urlSymbol")
        
        let bitcoinCashCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        bitcoinCashCoin.setValue("Bitcoin Cash", forKey: "nome")
        bitcoinCashCoin.setValue("BCH", forKey: "sigla")
        let imageData13 = UIImagePNGRepresentation(#imageLiteral(resourceName: "BCH"))! as NSData
        bitcoinCashCoin.setValue(imageData13, forKey: "logo")
        bitcoinCashCoin.setValue("bchusd", forKey: "urlSymbol")
        
        let neoCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        neoCoin.setValue("NEO", forKey: "nome")
        neoCoin.setValue("NEO", forKey: "sigla")
        let imageData14 = UIImagePNGRepresentation(#imageLiteral(resourceName: "NEO-alt"))! as NSData
        neoCoin.setValue(imageData14, forKey: "logo")
        neoCoin.setValue("neousd", forKey: "urlSymbol")
        
        let etpCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        etpCoin.setValue("ETP", forKey: "nome")
        etpCoin.setValue("ETP", forKey: "sigla")
        let imageData15 = UIImagePNGRepresentation(#imageLiteral(resourceName: "etp"))! as NSData
        etpCoin.setValue(imageData15, forKey: "logo")
        etpCoin.setValue("etpusd", forKey: "urlSymbol")
        
        let qtumCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        qtumCoin.setValue("Qtum", forKey: "nome")
        qtumCoin.setValue("QTUM", forKey: "sigla")
        let imageData16 = UIImagePNGRepresentation(#imageLiteral(resourceName: "quantum"))! as NSData
        qtumCoin.setValue(imageData16, forKey: "logo")
        qtumCoin.setValue("qtmusd", forKey: "urlSymbol")
        
        let aventusCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        aventusCoin.setValue("Aventus", forKey: "nome")
        aventusCoin.setValue("AVT", forKey: "sigla")
        let imageData17 = UIImagePNGRepresentation(#imageLiteral(resourceName: "avt"))! as NSData
        aventusCoin.setValue(imageData17, forKey: "logo")
        aventusCoin.setValue("avtusd", forKey: "urlSymbol")
        
        let eidooCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        eidooCoin.setValue("Eidoo", forKey: "nome")
        eidooCoin.setValue("EDO", forKey: "sigla")
        let imageData18 = UIImagePNGRepresentation(#imageLiteral(resourceName: "eidoo"))! as NSData
        eidooCoin.setValue(imageData18, forKey: "logo")
        eidooCoin.setValue("edousd", forKey: "urlSymbol")
        
        let btgCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        btgCoin.setValue("Bitcoin Gold", forKey: "nome")
        btgCoin.setValue("BTG", forKey: "sigla")
        let imageData19 = UIImagePNGRepresentation(#imageLiteral(resourceName: "btg"))! as NSData
        btgCoin.setValue(imageData19, forKey: "logo")
        btgCoin.setValue("btgusd", forKey: "urlSymbol")
        
        let streamCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        streamCoin.setValue("StreamR", forKey: "nome")
        streamCoin.setValue("DATA", forKey: "sigla")
        let imageData20 = UIImagePNGRepresentation(#imageLiteral(resourceName: "data2"))! as NSData
        streamCoin.setValue(imageData20, forKey: "logo")
        streamCoin.setValue("datusd", forKey: "urlSymbol")
        
        let qashCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        qashCoin.setValue("QASH", forKey: "nome")
        qashCoin.setValue("QASH", forKey: "sigla")
        let imageData21 = UIImagePNGRepresentation(#imageLiteral(resourceName: "quash3"))! as NSData
        qashCoin.setValue(imageData21, forKey: "logo")
        qashCoin.setValue("qshusd", forKey: "urlSymbol")
        
        let yoyowCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        yoyowCoin.setValue("YOYOW", forKey: "nome")
        yoyowCoin.setValue("YYW", forKey: "sigla")
        let imageData22 = UIImagePNGRepresentation(#imageLiteral(resourceName: "yoyow copy"))! as NSData
        yoyowCoin.setValue(imageData22, forKey: "logo")
        yoyowCoin.setValue("yywusd", forKey: "urlSymbol")
        
        let recoveryCoin = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        recoveryCoin.setValue("Recovery Right", forKey: "nome")
        recoveryCoin.setValue("RRT", forKey: "sigla")
        let imageData23 = UIImagePNGRepresentation(#imageLiteral(resourceName: "rrt"))! as NSData
        recoveryCoin.setValue(imageData23, forKey: "logo")
        recoveryCoin.setValue("rrtusd", forKey: "urlSymbol")
        
        let tron = NSEntityDescription.insertNewObject(forEntityName: "Coin", into: context)
        tron.setValue("Tron", forKey: "nome")
        tron.setValue("TRX", forKey: "sigla")
        let imageData222 = UIImagePNGRepresentation(#imageLiteral(resourceName: "rrt"))! as NSData
        tron.setValue(imageData222, forKey: "logo")
        tron.setValue("TRXBTC", forKey: "urlSymbol")
        
        do{
            try context.save()
        } catch {
            print("Erroa o salvar as coins")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: "firstRun")
        
    }
    
}
