//
//  ColorPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 9.10.21.
//

import UIKit
import CoreData

protocol ColorViewProtocol:AnyObject {
    func success()
    func failure(error:Error)
}

protocol ColorViewPresenterProtocol: AnyObject {
    init(view: ColorViewProtocol, storageService: ColorModelInput, router: RouterProtocol)
    func scaleUnit(tappedImage: UIImageView, array:Array<[UIView]>)
}

class ColorPresenter: ColorViewPresenterProtocol {
    
    weak var view: ColorViewProtocol?
    var router: RouterProtocol?
    let storageService: ColorModelInput!
    
    required init(view: ColorViewProtocol, storageService: ColorModelInput, router: RouterProtocol) {
        self.view = view
        self.storageService = storageService
        self.router = router
    }

    
    func scaleUnit(tappedImage: UIImageView, array:Array<[UIView]>) {
        for (index, item) in array.enumerated(){
            if index == tappedImage.tag - 1{
                item[0].transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                item[1].transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            } else {
                item[0].transform = .identity
                item[1].transform = .identity
            }
        }
    }
}
