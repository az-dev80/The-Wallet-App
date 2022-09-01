//
//  WalletDetailsVC.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 11.10.21.
//

import UIKit
import CoreData

class WalletDetailsVC: UIViewController {

    var presenter: WalletDetailsViewPresenterProtocol!
    var walletCurrency: String!
    var walletBackground: String!
    
    var const75 = CGFloat()
    var const20 = CGFloat()
    var const30 = CGFloat()
    var const40 = CGFloat()
    
    private let viewLabel:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.layer.cornerRadius = 20
        aview.clipsToBounds = true

        return aview
    }()
    
    private let walletName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 20
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        return label
    }()
    
    private let buttonBack: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "backButton"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return bt
    }()
    
    private let buttonWalletChange: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "changeWallet"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonWalletChangeAction), for: .touchUpInside)
        
        return bt
    }()
    
    private let viewTotal:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        aview.layer.cornerRadius = 20
        return aview
    }()
    
    private let walletTotal:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.font = UIFont(name: "Montserrat-Medium", size: 36)
        
        return label
    }()
    
    private let viewStack:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        aview.layer.cornerRadius = 20
        return aview
    }()
    
    private let stackLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transactions"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        
        return label
    }()
    
    private var viewButtonSeeAll = UIView()
//        = {
//        var aview = GradientBG(frame: .zero, rad: view.bounds.height)
//        aview.translatesAutoresizingMaskIntoConstraints = false
//        aview.layer.cornerRadius = 10
//        aview.clipsToBounds = true
//
//        return aview
//    }()
    
    private let buttonSeeAll: UIButton = {
        let bt = UIButton()
        bt.setTitle("See all", for: .normal)
        bt.setTitleColor(UIColor(red: 0.247, green: 0.533, blue: 0.773, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 20)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonSeeAllAction), for: .touchUpInside)
        
        return bt
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //layout.itemSize = .init(width: 360, height: 208)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TransactionCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    private var viewButtonAddTransaction = UIView()
//        = {
//        var aview = GradientBG(frame: .zero, rad: 10)
//        aview.translatesAutoresizingMaskIntoConstraints = false
//        aview.layer.cornerRadius = 10
//        aview.clipsToBounds = true
//
//        return aview
//    }()
    
    private let buttonAddTransaction: UIButton = {
        let bt = UIButton()
        bt.setTitle("Add transaction", for: .normal)
        bt.setTitleColor(UIColor(red: 0.247, green: 0.533, blue: 0.773, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 20)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonAddTransactionAction), for: .touchUpInside)
        
        return bt
    }()
    
    @objc func buttonAction(){
        //presenter.saveWallet(name: titleInput.text ?? "")
        if let presenter = presentingViewController as? ViewController {
            presenter.reloadCollection()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonWalletChangeAction(){
        presenter.openChangeWalletVC()
    }
    
    @objc func buttonSeeAllAction(){
        presenter.openAllTransactionsVC()
    }
    
    @objc func buttonAddTransactionAction(){
        presenter.openAddTransactionVC()
    }
    
    func configureViewForButtons() -> UIView {
        let aview = GradientBG(frame: .zero, rad: view.bounds.height*35/1750)
        print(view.bounds.height*35/1750)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.layer.cornerRadius = 10
        aview.clipsToBounds = true
        return aview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewButtonSeeAll = configureViewForButtons()
        viewButtonAddTransaction = configureViewForButtons()
        view.addSubview(viewLabel)
        view.addSubview(walletName)
        view.addSubview(buttonBack)
        view.addSubview(buttonWalletChange)
        view.addSubview(viewTotal)
        view.addSubview(walletTotal)
        view.addSubview(viewStack)
        view.addSubview(stackLabel)
        view.addSubview(viewButtonSeeAll)
        view.addSubview(buttonSeeAll)
        view.addSubview(collectionView)
        view.addSubview(viewButtonAddTransaction)
        view.addSubview(buttonAddTransaction)
        
        setupconstraint()
        
        presenter.setWallet()
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupconstraint(){
        let scaleWidth = view.bounds.width/414
        let scaleHeight = view.bounds.height/875
        const20 = view.bounds.height*20/791
        const30 = view.bounds.height*30/791
        const40 = view.bounds.height*35/791
        const75 = view.bounds.height*75/791
        
        viewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        buttonBack.centerYAnchor.constraint(equalTo: viewLabel.centerYAnchor).isActive = true
        buttonBack.widthAnchor.constraint(equalToConstant: const40).isActive = true
        buttonBack.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: const30).isActive = true
        buttonBack.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        walletName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        walletName.trailingAnchor.constraint(equalTo: buttonWalletChange.leadingAnchor, constant: -const20).isActive = true
        walletName.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: const20).isActive = true
        walletName.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        buttonWalletChange.centerYAnchor.constraint(equalTo: viewLabel.centerYAnchor).isActive = true
        buttonWalletChange.widthAnchor.constraint(equalToConstant: const40).isActive = true
        buttonWalletChange.trailingAnchor.constraint(equalTo: viewLabel.trailingAnchor, constant: -const30).isActive = true
        buttonWalletChange.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        viewTotal.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: const40).isActive = true
        viewTotal.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewTotal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        viewTotal.heightAnchor.constraint(equalToConstant: 100*scaleHeight).isActive = true
        
        walletTotal.centerYAnchor.constraint(equalTo: viewTotal.centerYAnchor).isActive = true
        walletTotal.centerXAnchor.constraint(equalTo: viewTotal.centerXAnchor).isActive = true
        walletTotal.widthAnchor.constraint(equalToConstant: 120*scaleWidth).isActive = true
        walletTotal.topAnchor.constraint(equalTo: viewTotal.topAnchor, constant: 26*scaleHeight).isActive = true
        
        viewStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -const30).isActive = true
        viewStack.topAnchor.constraint(equalTo: viewTotal.bottomAnchor, constant: const20).isActive = true
        viewStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        
        stackLabel.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 24*scaleHeight).isActive = true
        stackLabel.heightAnchor.constraint(equalToConstant: 22*scaleHeight).isActive = true
        stackLabel.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor, constant: 36*scaleWidth).isActive = true
        stackLabel.widthAnchor.constraint(equalToConstant: 112*scaleWidth).isActive = true
        
        viewButtonSeeAll.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 20*scaleHeight).isActive = true
        viewButtonSeeAll.heightAnchor.constraint(equalToConstant: 40*scaleHeight).isActive = true
        viewButtonSeeAll.trailingAnchor.constraint(equalTo: viewStack.trailingAnchor, constant: -28*scaleWidth).isActive = true
        viewButtonSeeAll.widthAnchor.constraint(equalToConstant: 114*scaleWidth).isActive = true
        
        buttonSeeAll.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 20*scaleHeight).isActive = true
        buttonSeeAll.heightAnchor.constraint(equalToConstant: 40*scaleHeight).isActive = true
        buttonSeeAll.trailingAnchor.constraint(equalTo: viewButtonSeeAll.trailingAnchor, constant: -22*scaleWidth).isActive = true
        buttonSeeAll.leadingAnchor.constraint(equalTo: viewButtonSeeAll.leadingAnchor, constant: 22*scaleWidth).isActive = true
        //buttonSeeAll.widthAnchor.constraint(equalToConstant: 114*scaleWidth).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 80*scaleHeight).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -85*scaleHeight).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: viewStack.trailingAnchor, constant: 0).isActive = true
        
        viewButtonAddTransaction.heightAnchor.constraint(equalToConstant: 40*scaleHeight).isActive = true
        viewButtonAddTransaction.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -20*scaleHeight).isActive = true
        viewButtonAddTransaction.centerXAnchor.constraint(equalTo: viewStack.centerXAnchor).isActive = true
        viewButtonAddTransaction.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor, constant: 85*scaleWidth).isActive = true
        
        buttonAddTransaction.heightAnchor.constraint(equalToConstant: 40*scaleHeight).isActive = true
        buttonAddTransaction.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -20*scaleHeight).isActive = true
        buttonAddTransaction.centerXAnchor.constraint(equalTo: viewButtonAddTransaction.centerXAnchor).isActive = true
        buttonAddTransaction.leadingAnchor.constraint(equalTo: viewButtonAddTransaction.leadingAnchor, constant: 24*scaleWidth).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewLabel)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewTotal)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewStack)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewButtonSeeAll, radius: view.bounds.height*35/1750)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewButtonAddTransaction, radius: view.bounds.height*35/1750)
    }

    func reloadCollection(){
        presenter.getTransactions()
        collectionView.reloadData()
     }
}

extension WalletDetailsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getArrayOfAllTransactions()
        if presenter.arrayOfAllTransactions?.count ?? 0 > 4 { return 4 }
        else { return presenter.arrayOfAllTransactions?.count ?? 0}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TransactionCell
        presenter.setTransactionCell(cell: cell, indexPath: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding = sectionInsets.left * (itemsPerRow + 1)
        //let availableWidth = view.frame.width - padding
        //let widthPerItem = availableWidth / itemsPerRow
        let scaleWidth = view.bounds.width/414
        let scaleHeight = view.bounds.height/875
        print(view.bounds.height)
        return CGSize(width: 325*scaleWidth, height: 82*scaleHeight)
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.openTransactionDetailsVC(indexPath: indexPath)

    }

}

extension WalletDetailsVC: WalletDetailsViewProtocol {
    
    func setWallet(wallet: NSManagedObject?) {
        walletName.text = wallet?.value(forKeyPath: "nameWallet") as? String
        
        walletCurrency = wallet?.value(forKeyPath: "currency") as? String
        
        let sum = presenter.getSumOfAllTransactions()
        let locale = NSLocale(localeIdentifier: walletCurrency ?? "USD")
        if locale.displayName(forKey: .currencySymbol, value: walletCurrency!) == walletCurrency {
            walletTotal.text = "\(sum) \(walletCurrency ?? "")"
        }
        else {
            walletTotal.text = "\(sum) \(locale.displayName(forKey: .currencySymbol, value: walletCurrency ?? "$") ?? "")"
        }
        presenter.saveSum(sum: walletTotal.text!)
        presenter.saveLastActivityFullDate()
        
        walletBackground = wallet?.value(forKeyPath: "colorScheme") as? String ?? "bg1"
        
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: walletBackground)?.draw(in: view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image!)
        view.contentMode = .bottom
    }
    
    func setTransactionCell(cell: TransactionCell, transaction: [String]?) {
        let type = 0
        let amount = 1
        let shortdate = 3
        let icon = 5
        
        let code = presenter.wallet?.value(forKeyPath: "currency") as? String
        let locale = NSLocale(localeIdentifier: code ?? "USD")
        if locale.displayName(forKey: .currencySymbol, value: code!) == code {
            cell.amountLabel.text = "\(transaction![amount])\(code ?? "")"
        }
        else {
            cell.amountLabel.text = "\(transaction![amount])\(locale.displayName(forKey: .currencySymbol, value: code ?? "$") ?? "")"
        }

        cell.typeLabel.text = transaction?[type]
        cell.dateLabel.text = transaction?[shortdate]
        cell.iconImage.image = UIImage(systemName: transaction?[icon] ?? "barcode")
        
        cell.backgroundColor = .clear
        let aview = GradientBG(frame: cell.frame)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: aview)
        cell.backgroundView = aview
    }
    
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
