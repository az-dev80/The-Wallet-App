//
//  WalletsPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 6.10.21.
//

import Foundation
import CoreData

protocol WalletsViewProtocol:AnyObject {
    func success()
    func failure(error:Error)
}

protocol WalletsViewPresenterProtocol: AnyObject {
    init(view: WalletsViewProtocol, storageService: WalletsModelInput, router: RouterProtocol)
    func    getWallets()
    var     wallets:[NSManagedObject]? { get set }
    func    tapPlusButton()
    func    openWalletDetailsVC(wallet: NSManagedObject, walletIndex: IndexPath)
    func    deleteAllWallets()
}

class WalletsPresenter: WalletsViewPresenterProtocol {
    
    public weak var view: WalletsViewProtocol?
    var router: RouterProtocol?
    var storageService: WalletsModelInput!
    var wallets: [NSManagedObject]?
    
    required init(view: WalletsViewProtocol, storageService: WalletsModelInput, router: RouterProtocol) {
        self.view = view
        self.storageService = storageService
        self.router = router
        getWallets()
    }
    
    func getWallets() {
        storageService.getWallets { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let wallets):
                    self.wallets = wallets
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error:error)
                }
            }
        }
    }
    
    func tapPlusButton() {
        router?.showAddWalletVC()
    }
    
    func openWalletDetailsVC(wallet: NSManagedObject, walletIndex: IndexPath) {
        router?.showWalletDetalsVC(wallet: wallet, walletIndex: walletIndex)
    }
    
    func deleteAllWallets(){
        storageService.deleteAllData(entity: "Wallet")
    }
    
}

//protocol WalletsView: AnyObject {
//    func refreshWalletsView()
//    func displayWalletsRetrievalError(title: String, message: String)
//    func displayWalletDeleteError(title: String, message: String)
//    func deleteAnimated(row: Int)
//    func endEditing()
//}
//
//protocol WalletCellView {
//    func display(title: String)
//    func display(currency: String)
//    func display(dateTransaction: String)
//}
//
//protocol WalletsPresenter {
//    var numberOfWallets: Int { get }
//    var router: WalletsRouter { get }
//    func viewDidLoad()
//    func configure(cell: WalletCellView, forRow row: Int)
//    func didSelect(row: Int)
//    func canEdit(row: Int) -> Bool
//    func titleForDeleteButton(row: Int) -> String
//    func deleteButtonPressed(row: Int)
//    func addButtonPressed()
//}
//
//class WalletsPresenterImplementation: WalletsPresenter, AddWalletPresenterDelegate {
//    fileprivate weak var view: WalletsView?
//    fileprivate let displayWalletsUseCase: DisplayWalletsUseCase
//    fileprivate let deleteWalletUseCase: DeleteWalletUseCase
//    internal let router: WalletsRouter
//
//    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
//    var wallets = [Wallet]()
//
//    var numberOfWallets: Int {
//        return wallets.count
//    }
//
//    init(view: WalletsView,
//         displayWalletsUseCase: DisplayWalletsUseCase,
//         deleteWalletUseCase: DeleteWalletUseCase,
//         router: WalletsRouter) {
//        self.view = view
//        self.displayWalletsUseCase = displayWalletsUseCase
//        self.deleteWalletUseCase = deleteWalletUseCase
//        self.router = router
//
//        registerForDeleteWalletNotification()
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    // MARK: - BooksPresenter
//
//    func viewDidLoad() {
//        self.displayWalletsUseCase.displayWallets { (result) in
//            switch result {
//            case let .success(wallets):
//                self.handleWalletsReceived(wallets)
//            case let .failure(error):
//                self.handleWalletsError(error)
//            }
//        }
//    }
//
//    func configure(cell: WalletCellView, forRow row: Int) {
//        let wallet = wallets[row]
//
//        cell.display(title: wallet.title)
//        cell.display(currency: wallet.currency)
//        cell.display(dateTransaction: wallet.releaseDate?.relativeDescription() ?? "Unknown")
//    }
//
//    func didSelect(row: Int) {
//        let wallet = wallets[row]
//
//        router.presentDetailsView(for: wallet)
//    }
//
//    func canEdit(row: Int) -> Bool {
//        return true
//    }
//
//    func titleForDeleteButton(row: Int) -> String {
//        return "Delete Wallet"
//    }
//
//    func deleteButtonPressed(row: Int) {
//        view?.endEditing()
//
//        let wallet = wallets[row]
//        deleteWalletUseCase.delete(wallet: wallet) { (result) in
//            switch result {
//            case .success():
//                self.handleWalletDeleted(wallet: wallet)
//            case let .failure(error):
//                self.handleWalletDeleteError(error)
//            }
//        }
//    }
//
//    func addButtonPressed() {
//        router.presentAddWallet(addWalletPresenterDelegate: self)
//    }
//
//    // MARK: - AddWalletPresenterDelegate
//
//    func addWalletkPresenter(_ presenter: AddWalletPresenter, didAdd wallet: Wallet) {
//        presenter.router.dismiss()
//        wallets.append(wallet)
//        view?.refreshWalletsView()
//    }
//
//    func addWalletPresenterCancel(presenter: AddWalletPresenter) {
//        presenter.router.dismiss()
//    }
//
//    // MARK: - Private
//
//    fileprivate func handleWalletsReceived(_ wallets: [Wallet]) {
//        self.wallets = wallets
//        view?.refreshWalletsView()
//    }
//
//    fileprivate func handleWalletsError(_ error: Error) {
//        // Here we could check the error code and display a localized error message
//        view?.displayWalletsRetrievalError(title: "Error", message: error.localizedDescription)
//    }
//
//    fileprivate func registerForDeleteWalletNotification() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(didReceiveDeleteWalletNotification),
//                                               name: DeleteWalletUseCaseNotifications.didDeleteWallet,
//                                               object: nil)
//    }
//
//    @objc fileprivate func didReceiveDeleteWalletNotification(_ notification: Notification) {
//        if let wallet = notification.object as? Wallet {
//            handleWalletDeleted(wallet: wallet)
//        }
//    }
//
//    fileprivate func handleWalletDeleted(wallet: Wallet) {
//        // The wallet might have already be deleted due to the notification response
//        if let row = wallets.firstIndex(of: wallet) {
//            wallets.remove(at: row)
//            view?.deleteAnimated(row: row)
//        }
//    }
//
//    fileprivate func handleWalletDeleteError(_ error: Error) {
//        view?.displayWalletDeleteError(title: "Error", message: error.localizedDescription)
//    }
//}
