//
//  Compra+CoreDataProperties.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 20/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//
//

import Foundation
import CoreData


extension Compra {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Compra> {
        return NSFetchRequest<Compra>(entityName: "Compra")
    }

    @NSManaged public var data: NSDate?
    @NSManaged public var qtd: Double
    @NSManaged public var valorBitcoin: Double
    @NSManaged public var valorUnitario: Double
    @NSManaged public var relCoin: Coin?

}
