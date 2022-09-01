//
//  AddTransactionModel.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 12.10.21.
//

import UIKit
import CoreData

protocol AddTransactionModelInput {
    func save(wallet: NSManagedObject, transactionType: String, transactionAmount: String, transactionNote: String, transactionDate: Date, transactionIcon: String)
}

final class AddTransactionModel: AddTransactionModelInput {
    
    func save(wallet: NSManagedObject, transactionType: String, transactionAmount: String, transactionNote: String, transactionDate: Date, transactionIcon: String) {
        let shortdateFormatter = DateFormatter()
        shortdateFormatter.dateFormat = "d MMM"
        let shortDate = shortdateFormatter.string(from: transactionDate)
        
        let fulldateFormatter = DateFormatter()
        fulldateFormatter.dateFormat = "MMMM d, yyyy"
        let fullDate = fulldateFormatter.string(from: transactionDate)
        
        let transactionArray:[String] = [transactionType, transactionAmount, transactionNote, shortDate, fullDate, transactionIcon]
        
        var arrayBack: [[String]] = []
        
        let stringOfTransactions = wallet.value(forKeyPath: "transaction") as? String
        if stringOfTransactions != nil  {
            let stringAsData = stringOfTransactions!.data(using: String.Encoding.utf16)
            arrayBack = try! JSONDecoder().decode([[String]].self, from: stringAsData!)
        }
        arrayBack.append(transactionArray)
//        let set = [
//            "type": transactionType,
//            "amount":transactionAmount,
//            "note": transactionNote,
//            "date": transactionDate,
//            "icon": transactionIcon
//        ] as [String : Any]
        let arrayAsString: String = arrayBack.description
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        //let entity = NSEntityDescription.entity(forEntityName: "Wallet", in: managedContext)!
        //let transaction = NSManagedObject(entity: entity, insertInto: managedContext)
        
        wallet.setValue(arrayAsString, forKeyPath: "transaction")
        wallet.setValue(fullDate, forKeyPath: "fullDate")
        do {
            try managedContext.save()
           // wallets.append(wallet)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
