//
//  WalletDetailsPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 11.10.21.
//

import Foundation
import CoreData

protocol WalletDetailsViewProtocol:AnyObject {
    func setWallet(wallet: NSManagedObject?)
    func setTransactionCell(cell: TransactionCell, transaction: [String]?)
    func success()
    func failure(error:Error)
}

protocol WalletDetailsViewPresenterProtocol: AnyObject {
    init(view: WalletDetailsViewProtocol, storageService: WalletDetailsModelInput, router: RouterProtocol, wallet: NSManagedObject, walletIndex: IndexPath)
    func    setWallet()
    func    getTransactions()
    func    getArrayOfAllTransactions()
    func    setTransactionCell(cell: TransactionCell, indexPath: IndexPath)
    var     arrayOfAllTransactions: [[String]]? { get set }
    func    getSumOfAllTransactions() -> Double
    func    saveLastActivityFullDate()
    func    saveSum(sum: String)
    var     wallet:NSManagedObject? { get set }
    func    openAddTransactionVC()
    func    openAllTransactionsVC()
    func    openTransactionDetailsVC(indexPath: IndexPath)
    func    openChangeWalletVC()
    func    deleteAllWallets()
}

class WalletDetailsPresenter: WalletDetailsViewPresenterProtocol {
   
    public weak var view: WalletDetailsViewProtocol?
    var router: RouterProtocol?
    var storageService: WalletDetailsModelInput!
    var wallet: NSManagedObject?
    var arrayOfAllTransactions: [[String]]?
    let walletIndex:IndexPath?
    
    required init(view: WalletDetailsViewProtocol, storageService: WalletDetailsModelInput, router: RouterProtocol, wallet: NSManagedObject, walletIndex: IndexPath) {
        self.view = view
        self.storageService = storageService
        self.router = router
        self.wallet = wallet
        self.walletIndex = walletIndex
        getTransactions()
    }
    
    func setWallet() {
        self.view?.setWallet(wallet: wallet)
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
    
    func setTransactionCell(cell: TransactionCell, indexPath: IndexPath) {
        getArrayOfAllTransactions()
        let transaction = arrayOfAllTransactions?[indexPath.row]
        self.view?.setTransactionCell(cell: cell, transaction: transaction)
    }
    
    func getSumOfAllTransactions() -> Double {
        getArrayOfAllTransactions()
        let array = arrayOfAllTransactions?.map { $0[1] }
        let sum = array?.reduce(0) { $0 + (Double($1) ?? .zero) } ?? 0
        return sum
    }
    
    func saveSum(sum: String) {
        storageService.saveSum(sum: sum, wallet: wallet!)
    }
    
    func saveLastActivityFullDate() {
        let array = arrayOfAllTransactions?[0] ?? []
        var fulldate = ""
        if !array.isEmpty {
            fulldate = array[4]
        } else {
            fulldate = "No activity"
        }
        storageService.saveLastActivityFullDate(fulldate: fulldate, wallet: wallet!)
    }
    
    func openAddTransactionVC() {
        router?.showAddTransactionVC(wallet: wallet!) 
    }
    
    func openAllTransactionsVC() {
        getArrayOfAllTransactions()
        router?.showAllTransactionsVC(wallet: wallet!, array: arrayOfAllTransactions ?? [[]])
    }
    
    func openTransactionDetailsVC(indexPath: IndexPath) {
        router?.showTransactionDetailsVC(wallet: wallet!, array: arrayOfAllTransactions ?? [[]], presenter: "WalletDetailsPresenter", indexPath: indexPath)
    }
    
    func openChangeWalletVC() {
        router?.showChangeWalletVC(wallet: wallet!, walletIndex: walletIndex!)
    }
    
    func deleteAllWallets(){
        //storageService.deleteAllData(entity: "Wallet")
    }
    
}
