//
//  WalletsConfigurator.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 6.10.21.
//

import UIKit



//protocol WalletsConfigurator {
//    func configure(walletsViewController: ViewController)
//}
//
//class WalletsConfiguratorImplementation: WalletsConfigurator {
//
//    func configure(walletsViewController: ViewController) {
//        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
//                                                completionHandlerQueue: OperationQueue.main)
//        let apiBooksGateway = ApiBooksGatewayImplementation(apiClient: apiClient)
//        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
//        let coreDataBooksGateway = CoreDataBooksGateway(viewContext: viewContext)
//
//        let booksGateway = CacheBooksGateway(apiBooksGateway: apiBooksGateway,
//                                             localPersistenceBooksGateway: coreDataBooksGateway)
//
//        let displayBooksUseCase = DisplayBooksListUseCaseImplementation(booksGateway: booksGateway)
//        let deleteBookUseCase = DeleteBookUseCaseImplementation(booksGateway: booksGateway)
//        let router = WalletsPresenterImplementation(walletsViewController: walletsViewController)
//
//        let presenter = WalletsPresenterImplementation(view: walletsViewController,
//                                                     displayBooksUseCase: displayBooksUseCase,
//                                                     deleteBookUseCase: deleteBookUseCase,
//                                                     router: router)
//
//        walletsViewController.presenter = presenter
//    }
//}
