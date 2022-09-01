//
//  ChangeTransactionModel.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 18.10.21.
//

import UIKit
import CoreData

protocol ChangeTransactionModelInput {
    var transactionsArray: [[String]]? { get set}
    var transactionArray: [String]? { get set}
    func saveArrays(arrayAll: [[String]], arrayTransaction: [String])
    func passArray2d() -> [[String]]
    func passArray() -> [String]
    func updateAllTransactionsData(arrayAsString: String, wallet: NSManagedObject)
}

final class ChangeTransactionModel: ChangeTransactionModelInput {
    
    var transactionsArray: [[String]]?
    var transactionArray: [String]?
    
    func saveArrays(arrayAll: [[String]], arrayTransaction: [String]) {
        transactionsArray = arrayAll
        transactionArray = arrayTransaction
    }

    func passArray2d() -> [[String]] {
        return transactionsArray ?? []
    }
    
    func passArray() -> [String] {
        return transactionArray ?? []
    }
    
    func updateAllTransactionsData(arrayAsString: String, wallet: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        wallet.setValue(arrayAsString, forKeyPath: "transaction")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
