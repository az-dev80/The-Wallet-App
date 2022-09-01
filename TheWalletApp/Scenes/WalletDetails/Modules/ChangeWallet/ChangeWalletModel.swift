//
//  ChangeWalletModel.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 18.10.21.
//

import UIKit
import CoreData

protocol ChangeWalletModelInput {
    func save(wallet: NSManagedObject, name: String, color: String, currency: String)
}

final class ChangeWalletModel: ChangeWalletModelInput {
    
    func save(wallet: NSManagedObject, name: String, color: String, currency: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Wallet", in: managedContext)!
//        let wallet = NSManagedObject(entity: entity, insertInto: managedContext)
        wallet.setValue(name, forKeyPath: "nameWallet")
        wallet.setValue(currency, forKeyPath: "currency")
        wallet.setValue(color, forKeyPath: "colorScheme")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
