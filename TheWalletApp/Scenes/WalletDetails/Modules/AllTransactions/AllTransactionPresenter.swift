//
//  AllTransactionPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 15.10.21.
//

import Foundation
import CoreData

protocol AllTransactionsViewProtocol:AnyObject {
    func setTransactionCell(cell: TransactionCell, transaction: [String]?)
    func setBackground(wallet: NSManagedObject?)
    func success()
    func failure(error:Error)
}

protocol AllTransactionsViewPresenterProtocol: AnyObject {
    init(view: AllTransactionsViewProtocol, storageService: AllTransactionsModelInput, router: RouterProtocol, wallet: NSManagedObject, array: [[String]])
    func    setBackground()
    func    setTransactionCell(cell: TransactionCell, indexPath: IndexPath)
    var     arrayOfAllTransactions: [[String]]? { get set }
    var     wallet:NSManagedObject? { get set }
    func    openTransactionDetailsVC(indexPath: IndexPath)
    func    getTransactions()
    func    getArrayOfAllTransactions()
    
}

class AllTransactionsPresenter: AllTransactionsViewPresenterProtocol {
   
    public weak var view: AllTransactionsViewProtocol?
    var router: RouterProtocol?
    var storageService: AllTransactionsModelInput!
    var wallet: NSManagedObject?
    var arrayOfAllTransactions: [[String]]?
    
    required init(view: AllTransactionsViewProtocol, storageService: AllTransactionsModelInput, router: RouterProtocol, wallet: NSManagedObject, array: [[String]]) {
        self.view = view
        self.storageService = storageService
        self.router = router
        self.wallet = wallet
        self.storageService.saveArray(array: array)
        self.arrayOfAllTransactions = self.storageService.passArray()
    }
    
    func setBackground() {
        self.view?.setBackground(wallet: wallet)
    }
    
    func setTransactionCell(cell: TransactionCell, indexPath: IndexPath) {
        let transaction = arrayOfAllTransactions?[indexPath.row]
        self.view?.setTransactionCell(cell: cell, transaction: transaction)
    }
    
    func getTransactions() {
        storageService.getTransactions(wallet: wallet!) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let wallet):
                    self.wallet = wallet
                    self.getArrayOfAllTransactions()
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error:error)
                }
            }
        }
    }
    
    func getArrayOfAllTransactions() {
        let stringTransactions = self.wallet?.value(forKeyPath: "transaction") as? String
        guard let stringAsData = stringTransactions?.data(using: String.Encoding.utf16) else { return }
        arrayOfAllTransactions = try! JSONDecoder().decode([[String]].self, from: stringAsData).reversed()
    }
    
    func openTransactionDetailsVC(indexPath: IndexPath) {
        router?.showTransactionDetailsVC(wallet: wallet!, array: arrayOfAllTransactions ?? [[]], presenter: "AllTransactionsPresenter", indexPath: indexPath) 
    }
    
    
}
