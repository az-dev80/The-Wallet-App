//
//  TransactionDetailsPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 15.10.21.
//

import Foundation
import CoreData

protocol TransactionDetailsViewProtocol:AnyObject {
    func setLabelText(fullDate: String, transactionType: String, amount: String, note: String)
    func setBackground(wallet: NSManagedObject?)
}

protocol TransactionDetailsViewPresenterProtocol: AnyObject {
    init(view: TransactionDetailsViewProtocol, storageService: TransactionDetailsModelInput, router: RouterProtocol, wallet: NSManagedObject, array: [[String]], indexPath: IndexPath)
    var     arrayOfAllTransactions: [[String]]? { get set }
    var     arrayOfTransaction: [String]? { get set }
    var     wallet:NSManagedObject? { get set }
    
    func    setBackground()
    func    setLabelText()
    func    updateLabelText()
    func    deleteThisTransaction()
    func    openChangeTransactionVC()
}

class TransactionDetailsPresenter: TransactionDetailsViewPresenterProtocol {
   
    public weak var view: TransactionDetailsViewProtocol?
    var router: RouterProtocol?
    var storageService: TransactionDetailsModelInput!
    var wallet: NSManagedObject?
    var arrayOfAllTransactions: [[String]]?
    var arrayOfTransaction: [String]?
    let indexPath: IndexPath?
    
    required init(view: TransactionDetailsViewProtocol, storageService: TransactionDetailsModelInput, router: RouterProtocol, wallet: NSManagedObject, array: [[String]], indexPath: IndexPath) {
        self.view = view
        self.storageService = storageService
        self.router = router
        self.wallet = wallet
        self.indexPath = indexPath
        self.storageService.saveArray(array: array, indexPath: indexPath)
        self.arrayOfAllTransactions = self.storageService.passArray2d()
        self.arrayOfTransaction = self.storageService.passArray()
    }
    
    func setBackground() {
        self.view?.setBackground(wallet: wallet)
    }
    
    func setLabelText() {
        let amount = arrayOfTransaction?[1] ?? ""
        var amounts = ""
        
        let walletCurrency = wallet?.value(forKeyPath: "currency") as? String
        let locale = NSLocale(localeIdentifier: walletCurrency ?? "USD")
        if locale.displayName(forKey: .currencySymbol, value: walletCurrency!) == walletCurrency {
            amounts = "\(amount) \(walletCurrency ?? "")"
        }
        else {
            amounts = "\(amount) \(locale.displayName(forKey: .currencySymbol, value: walletCurrency ?? "$") ?? "")"
        }
        
        let type = arrayOfTransaction?[0] ?? ""
        
        let note = arrayOfTransaction?[2] ?? ""
        let fulldate = arrayOfTransaction?[4] ?? ""
        
        self.view?.setLabelText(fullDate: fulldate, transactionType: type, amount: amounts, note: note)
    }
    
    func updateLabelText() {
        storageService.giveMeNewData(wallet: wallet!, indexPath: indexPath!)
        arrayOfTransaction = storageService.passArray()
        setLabelText()
    }
    
    func deleteThisTransaction() {
        self.arrayOfAllTransactions?.remove(at: self.indexPath!.row)
        let array: [[String]] = self.arrayOfAllTransactions!.reversed()
        let arrayAsString: String = array.description
        storageService.updateAllTransactionsData(arrayAsString: arrayAsString, wallet: wallet!)
    }
    
    func openChangeTransactionVC() {
        router?.showChangeTransactionVC(wallet: wallet!, arrayAll: arrayOfAllTransactions ?? [[]], arrayTransaction: arrayOfTransaction ?? [], indexPath: indexPath ?? [])
    }
    
}
