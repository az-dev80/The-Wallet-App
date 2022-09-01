//
//  WalletsModel.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 7.10.21.
//

import UIKit
import CoreData

protocol WalletsModelInput {
    func getWallets(completion: @escaping (Result<[NSManagedObject]?, Error>) -> (Void))
    func save(name: String, color: String, currency: String)
    func deleteAllData(entity: String)
}

final class WalletsModel: WalletsModelInput {

    var wallets: [NSManagedObject] = []
    
    func getWallets(completion: @escaping (Result<[NSManagedObject]?, Error>) -> (Void)) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Wallet")
        do {
            wallets = try managedContext.fetch(fetchRequest)
            completion(.success(wallets))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(.failure(error))
        }
    }

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
            wallets.append(wallet)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllData(entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }

    
}
