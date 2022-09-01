//
//  CurrencyPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 9.10.21.
//

import Foundation
import CoreData

protocol CurrencyViewProtocol:AnyObject {
    func success()
    func failure(error:Error)
}

protocol CurrencyViewPresenterProtocol: AnyObject {
    init(view: CurrencyViewProtocol, storageService: CurrencyModelInput, router: RouterProtocol)
    //func saveWallet(name:String)
}

class CurrencyPresenter: CurrencyViewPresenterProtocol {
    
    weak var view: CurrencyViewProtocol?
    var router: RouterProtocol?
    let storageService: CurrencyModelInput!
    var wallets: [NSManagedObject]?
    
    required init(view: CurrencyViewProtocol, storageService: CurrencyModelInput, router: RouterProtocol) {
        self.view = view
        self.storageService = storageService
        self.router = router
    }

   
    
//    func saveWallet(name: String) {
//        let color = getColor()
//        let currency = getCurrency()
//        //storageService.save(name: name, color: color, currency: currency)
//
//    }
}
