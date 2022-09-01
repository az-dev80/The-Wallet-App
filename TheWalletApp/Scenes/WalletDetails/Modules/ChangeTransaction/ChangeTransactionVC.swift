//
//  ChangeTransactionVC.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 18.10.21.
//

import Foundation
import UIKit
import CoreData

protocol ChangeTransactionViewProtocol:AnyObject {
    func setBackground(wallet: NSManagedObject?)
    func setLabelText(transactionType: String, amount: String, note: String)
}

protocol ChangeTransactionViewPresenterProtocol: AnyObject {
    init(view: ChangeTransactionViewProtocol, storageService: ChangeTransactionModelInput, router: RouterProtocol, wallet: NSManagedObject, arrayAll: [[String]], arrayTransaction: [String], indexPath: IndexPath)
    var wallet:NSManagedObject? { get set }
    func updateTransaction(transactionType: String, transactionAmount: String, transactionNote: String, buttonState: UIButton.State)
    func setBackground()
    func setLabelText()
}

class ChangeTransactionPresenter: ChangeTransactionViewPresenterProtocol {
    
    weak var view: ChangeTransactionViewProtocol?
    var router: RouterProtocol?
    let storageService: ChangeTransactionModelInput!
    var wallet: NSManagedObject?
    var arrayOfAllTransactions: [[String]]?
    var arrayOfTransaction: [String]?
    let indexPath: IndexPath?
    
    required init(view: ChangeTransactionViewProtocol, storageService: ChangeTransactionModelInput, router: RouterProtocol, wallet: NSManagedObject, arrayAll: [[String]], arrayTransaction: [String], indexPath: IndexPath) {
        self.view = view
        self.storageService = storageService
        self.router = router
        self.wallet = wallet
        self.indexPath = indexPath
        self.storageService.saveArrays(arrayAll: arrayAll, arrayTransaction: arrayTransaction)
        self.arrayOfAllTransactions = self.storageService.passArray2d()
        self.arrayOfTransaction = self.storageService.passArray()
    }
    
    func updateTransaction(transactionType: String, transactionAmount: String, transactionNote: String, buttonState: UIButton.State) {
        
        let shortDate = arrayOfTransaction?[3] ?? ""
        let fullDate = arrayOfTransaction?[4] ?? ""
        let icon = arrayOfTransaction?[5] ?? ""
        var amount = transactionAmount
        if buttonState.rawValue == 0 {
            amount = "-\(transactionAmount)"
        } else {
            amount = transactionAmount
        }
        
        let arrayToUpdate: [String] = [transactionType, amount, transactionNote, shortDate, fullDate, icon]
        
        arrayOfAllTransactions?[indexPath!.row] = arrayToUpdate
        let array: [[String]] = arrayOfAllTransactions!.reversed()
        let arrayAsString: String = array.description
        storageService.updateAllTransactionsData(arrayAsString: arrayAsString, wallet: wallet!)
    }
    
    func setBackground() {
        self.view?.setBackground(wallet: wallet)
    }
    
    func setLabelText() {
        let amount = arrayOfTransaction?[1] ?? ""
        let type = arrayOfTransaction?[0] ?? ""
        let note = arrayOfTransaction?[2] ?? ""
        self.view?.setLabelText(transactionType: type, amount: amount, note: note)
    }
}
