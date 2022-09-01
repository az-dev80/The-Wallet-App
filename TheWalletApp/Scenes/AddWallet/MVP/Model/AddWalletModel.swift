//
//  AddWalletModel.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 9.10.21.
//

import UIKit
import CoreData

protocol AddWalletModelInput {
    func save(name: String, color: String, currency: String)
}

final class AddWalletsModel: AddWalletModelInput {
    
    func save(name: String, color: String, currency: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Wallet", in: managedContext)!
        let wallet = NSManagedObject(entity: entity, insertInto: managedContext)
        wallet.setValue(name, forKeyPath: "nameWallet")
        wallet.setValue(currency, forKeyPath: "currency")
        wallet.setValue(color, forKeyPath: "colorScheme")
        do {
            try managedContext.save()
           // wallets.append(wallet)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
