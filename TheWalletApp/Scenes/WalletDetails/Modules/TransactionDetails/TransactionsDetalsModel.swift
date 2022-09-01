//
//  TransactionsDetalsModel.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 15.10.21.
//

import UIKit
import CoreData

protocol TransactionDetailsModelInput {
    var transactionsArray: [[String]]? { get set}
    var transactionArray: [String]? { get set}
    func saveArray(array: [[String]], indexPath: IndexPath)
    func passArray2d() -> [[String]]
    func passArray() -> [String]
    func giveMeNewData(wallet: NSManagedObject, indexPath: IndexPath)
    func updateAllTransactionsData(arrayAsString: String, wallet: NSManagedObject)
}

final class TransactionDetailsModel: TransactionDetailsModelInput {
   
    var transactionsArray: [[String]]?
    var transactionArray: [String]?
    
    func saveArray(array: [[String]], indexPath: IndexPath) {
        transactionsArray = array
        transactionArray = array[indexPath.row]
    }

    func passArray2d() -> [[String]] {
        return transactionsArray ?? []
    }
    
    func passArray() -> [String] {
        return transactionArray ?? []
    }
    
    func giveMeNewData(wallet: NSManagedObject, indexPath: IndexPath) {
        let stringTransactions = wallet.value(forKeyPath: "transaction") as? String
        guard let stringAsData = stringTransactions?.data(using: String.Encoding.utf16) else { return }
        transactionsArray = try! JSONDecoder().decode([[String]].self, from: stringAsData).reversed()
        transactionArray = transactionsArray?[indexPath.row]
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
