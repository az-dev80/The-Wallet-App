//
//  WalletDetailsModel.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 11.10.21.
//

import UIKit
import CoreData

protocol WalletDetailsModelInput {
    func getTransactions(wallet:NSManagedObject, completion: @escaping (Result<NSManagedObject?, Error>) -> (Void))
    func saveSum(sum: String, wallet: NSManagedObject)
    func saveLastActivityFullDate(fulldate: String, wallet: NSManagedObject)
}

final class WalletDetailsModel: WalletDetailsModelInput {
    
   var wallets: NSManagedObject?
    
    func getTransactions(wallet:NSManagedObject, completion: @escaping (Result<NSManagedObject?, Error>) -> (Void)) {
        //guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //let managedContext = appDelegate.persistentContainer.viewContext
        //let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Wallet")
        do {
            //wallets = try managedContext.fetch(fetchRequest)
            completion(.success(wallet))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(.failure(error))
        }
    }
    
    func saveSum(sum: String, wallet: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        wallet.setValue(sum, forKeyPath: "sum")
        do {
            try managedContext.save()
           // wallets.append(wallet)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveLastActivityFullDate(fulldate: String, wallet: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        wallet.setValue(fulldate, forKeyPath: "fullDate")
        do {
            try managedContext.save()
           // wallets.append(wallet)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

