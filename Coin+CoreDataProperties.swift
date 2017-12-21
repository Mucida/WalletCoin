//
//  Coin+CoreDataProperties.swift
//  WalletCoin
//
//  Created by Lucas Mucida Costa on 20/12/17.
//  Copyright © 2017 Lucas Mucida Costa. All rights reserved.
//
//

import Foundation
import CoreData


extension Coin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coin> {
        return NSFetchRequest<Coin>(entityName: "Coin")
    }

    @NSManaged public var emUso: Bool
    @NSManaged public var logo: NSData?
    @NSManaged public var nome: String?
    @NSManaged public var qtd: Double
    @NSManaged public var sigla: String?
    @NSManaged public var valor: Double
    @NSManaged public var investimento: Double
    @NSManaged public var urlSymbol: String?
    @NSManaged public var compra: NSSet?

}

// MARK: Generated accessors for compra
extension Coin {

    @objc(addCompraObject:)
    @NSManaged public func addToCompra(_ value: Compra)

    @objc(removeCompraObject:)
    @NSManaged public func removeFromCompra(_ value: Compra)

    @objc(addCompra:)
    @NSManaged public func addToCompra(_ values: NSSet)

    @objc(removeCompra:)
    @NSManaged public func removeFromCompra(_ values: NSSet)

}
