//
//  AddTransactionPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 12.10.21.
//

import Foundation
import UIKit
import CoreData

protocol AddTransactionViewProtocol:AnyObject {
    func setBackground(wallet: NSManagedObject?)
}

protocol AddTransactionViewPresenterProtocol: AnyObject {
    init(view: AddTransactionViewProtocol, storageService: AddTransactionModelInput, router: RouterProtocol, wallet: NSManagedObject)
    var wallet:NSManagedObject? { get set }
    func saveTransaction(transactionType: String, transactionAmount: String, transactionNote: String, buttonState: UIButton.State)
    func setBackground()
    
}

class AddTransactionPresenter: AddTransactionViewPresenterProtocol {
    
    weak var view: AddTransactionViewProtocol?
    var router: RouterProtocol?
    let storageService: AddTransactionModelInput! 
    var wallet:NSManagedObject?
    var transactions: [NSManagedObject]?
    var transactionType: String?
    var transactionAmount: String?
    var transactionNote: String?
    var transactionDate: Date?
    var transactionIcon: String?
    
    required init(view: AddTransactionViewProtocol, storageService: AddTransactionModelInput, router: RouterProtocol, wallet: NSManagedObject) {
        self.view = view
        self.storageService = storageService
        self.router = router
        self.wallet = wallet
    }

//    func setCurrencyText(button: UIButton, code: String) {
//        currencyCode = code
//        let locale = NSLocale(localeIdentifier: code)
//        if locale.displayName(forKey: .currencySymbol, value: code) == code {
//            button.setTitle(code, for: .normal)
//        }
//        else {
//            button.setTitle("\(code) \(locale.displayName(forKey: .currencySymbol, value: code) ?? "")", for: .normal)
//        }
//    }
//
//    func setColor(forImageView: UIImageView, color: String) {
//        colorCode = color
//        forImageView.image = UIImage(named: color)
//    }
    
    func saveTransaction(transactionType: String, transactionAmount: String, transactionNote: String, buttonState: UIButton.State) {
        
        transactionDate = Date()
        transactionIcon = SFSymbol.allCases.randomElement()?.rawValue
        self.transactionNote = transactionNote
        self.transactionType = transactionType
        
        if buttonState.rawValue == 0 {
            self.transactionAmount = "-\(transactionAmount)"
        } else {
            self.transactionAmount = transactionAmount
        }
        
        storageService.save(wallet:wallet!, transactionType: transactionType, transactionAmount: self.transactionAmount!, transactionNote: self.transactionNote ?? "", transactionDate: transactionDate!, transactionIcon: transactionIcon!)
    }
    
    func setBackground() {
        self.view?.setBackground(wallet: wallet)
    }
}
