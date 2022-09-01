//
//  AllTransactionsModel.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 15.10.21.
//

import UIKit
import CoreData

protocol AllTransactionsModelInput {
    var allTransactionsArray: [[String]]? { get set}
    func saveArray(array: [[String]])
    func passArray() -> [[String]]
    func getTransactions(wallet:NSManagedObject, completion: @escaping (Result<NSManagedObject?, Error>) -> (Void))
}

final class AllTransactionsModel: AllTransactionsModelInput {
   
    var allTransactionsArray: [[String]]?
    
    func saveArray(array: [[String]]) {
        allTransactionsArray = array
    }

    func passArray() -> [[String]] {
        return allTransactionsArray ?? [[]]
    }
    
    func getTransactions(wallet:NSManagedObject, completion: @escaping (Result<NSManagedObject?, Error>) -> (Void)) {
        
        do {
            completion(.success(wallet))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(.failure(error))
        }
    }
}
