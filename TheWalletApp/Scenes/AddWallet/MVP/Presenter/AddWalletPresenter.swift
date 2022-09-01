//
//  AddWalletPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 7.10.21.
//

import UIKit
import CoreData

protocol AddWalletViewProtocol:AnyObject {
    func success()
    func failure(error:Error)
}

protocol AddWalletViewPresenterProtocol: AnyObject {
    init(view: AddWalletViewProtocol, storageService: WalletsModelInput, router: RouterProtocol)
    func saveWallet(name:String)
    func showColorVC()
    func showCurrencyVC()
    func setCurrencyText(button: UIButton, code: String)
    func setColor(forImageView: UIImageView, color: String)
}

class AddWalletPresenter: AddWalletViewPresenterProtocol {
    
    weak var view: AddWalletViewProtocol?
    var router: RouterProtocol?
    let storageService: WalletsModelInput!
    var wallets: [NSManagedObject]?
    var currencyCode: String?
    var colorCode: String?
    
    required init(view: AddWalletViewProtocol, storageService: WalletsModelInput, router: RouterProtocol) {
        self.view = view
        self.storageService = storageService
        self.router = router
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
        storageService.save(name: name, color: colorCode ?? "bg1", currency: currencyCode ?? "USD")
    }
    
    func showColorVC() {
        router?.showColorVC(presenter: "AddWalletVC")
    }
    
    func showCurrencyVC() {
        router?.showCurrencyVC(presenter: "AddWalletVC")
    }
}
