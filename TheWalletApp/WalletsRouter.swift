//
//  WalletsRouter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 6.10.21.
//

//import Foundation
//
//protocol WalletsRouter: ViewRouter {
//    func presentDetailsView(for wallet: Wallet)
//    func presentAddWallet(addWalletPresenterDelegate: AddWalletPresenterDelegate)
//}
//
//class WalletsViewRouterImplementation: WalletsRouter {
//    fileprivate weak var walletsViewController: ViewController?
//    fileprivate weak var addWalletPresenterDelegate: AddWalletPresenterDelegate?
//    fileprivate var wallet: Wallet!
//    
//    init(walletsViewController: ViewController) {
//        self.walletsViewController = walletsViewController
//    }
//    
//    // MARK: - WalletsRouter
//    
//    func presentDetailsView(for wallet: Wallet) {
//        self.wallet = wallet
//        walletsViewController?.present(walletsDetailViewController!, animated: true, completion: nil)
//        booksTableViewController?.performSegue(withIdentifier: "BooksSceneToBookDetailsSceneSegue", sender: nil)
//    }
//    
//    func presentAddBook(addBookPresenterDelegate: AddBookPresenterDelegate) {
//        self.addBookPresenterDelegate = addBookPresenterDelegate
//        booksTableViewController?.performSegue(withIdentifier: "BooksSceneToAddBookSceneSegue", sender: nil)
//    }
//    
//    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let bookDetailsTableViewController = segue.destination as? BookDetailsTableViewController {
//            bookDetailsTableViewController.configurator = BookDetailsConfiguratorImplementation(book: book)
//        } else if let navigationController = segue.destination as? UINavigationController,
//            let addBookViewController = navigationController.topViewController as? AddBookViewController {
//            addBookViewController.configurator = AddBookConfiguratorImplementation(addBookPresenterDelegate: addBookPresenterDelegate)
//        }
//    }
//    
//}
