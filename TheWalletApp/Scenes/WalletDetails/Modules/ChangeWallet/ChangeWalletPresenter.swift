//
//  ChangeWalletPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 18.10.21.
//

import UIKit
import CoreData

protocol ChangeWalletViewProtocol:AnyObject {
    func setBackground(wallet: NSManagedObject)
    func setInitialValues(walletName: String, walletCurrency: String, walletBG: String)
    func success()
    func failure(error:Error)
}

protocol ChangeWalletViewPresenterProtocol: AnyObject {
    init(view: ChangeWalletViewProtocol, storageService: ChangeWalletModelInput, router: RouterProtocol, wallet: NSManagedObject, walletIndex: IndexPath)
    func setBackground()
    func setInitialValues()
    
    func saveWallet(name:String)
    func setCurrencyText(button: UIButton, code: String)
    func setColor(forImageView: UIImageView, color: String)
    func deleteWallet()
   
    func showColorVC()
    func showCurrencyVC()
    
    var wallet:NSManagedObject? { get set }
}

class ChangeWalletPresenter: ChangeWalletViewPresenterProtocol {
    
    weak var view: ChangeWalletViewProtocol?
    var router: RouterProtocol?
    let storageService: ChangeWalletModelInput!
    var wallets: [NSManagedObject]?
    var currencyCode: String?
    var colorCode: String?
    let walletIndex: IndexPath?
    var wallet:NSManagedObject?
    
    required init(view: ChangeWalletViewProtocol, storageService: ChangeWalletModelInput, router: RouterProtocol, wallet: NSManagedObject, walletIndex: IndexPath) {
        self.view = view
        self.storageService = storageService
        self.router = router
        self.wallet = wallet
        self.walletIndex = walletIndex
    }

    func setCurrencyText(button: UIButton, code: String) {
        currencyCode = code
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            button.setTitle(code, for: .normal)
        }
        else {
            button.setTitle("\(code) \(locale.displayName(forKey: .currencySymbol, value: code) ?? "")", for: .normal)
        }
    }
    
    func setColor(forImageView: UIImageView, color: String) {
        colorCode = color
        forImageView.image = UIImage(named: color)
    }
    
    func saveWallet(name: String) {
        storageService.save(wallet: wallet!, name: name, color: colorCode ?? "bg1", currency: currencyCode ?? "USD")
    }
    
    func setBackground() {
        self.view?.setBackground(wallet: wallet!)
    }
    
    func setInitialValues() {
        let walletName = self.wallet?.value(forKeyPath: "nameWallet") as? String
        let walletCurrency = self.wallet?.value(forKeyPath: "currency") as? String
        let walletBG = self.wallet?.value(forKeyPath: "colorScheme") as? String
        
        self.view?.setInitialValues(walletName: walletName ?? "No name", walletCurrency: walletCurrency ?? "USD", walletBG: walletBG ?? "bg1")
    }
    
    func deleteWallet() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(self.wallet!)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func showColorVC() {
        router?.showColorVC(presenter: "WalletDetails")
    }
    
    func showCurrencyVC() {
        router?.showCurrencyVC(presenter: "WalletDetails")
    }
}

