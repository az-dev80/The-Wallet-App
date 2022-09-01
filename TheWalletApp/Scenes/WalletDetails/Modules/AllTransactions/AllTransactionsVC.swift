//
//  AllTransactionsVC.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 15.10.21.
//

import UIKit
import CoreData

class AllTransactionsVC: UIViewController {

    var presenter: AllTransactionsViewPresenterProtocol!
    
    private let viewLabel:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        return aview
    }()
    
    private let walletLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transactions"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        return label
    }()
    
    private let button: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "addNewWallet"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
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
    
    @objc func buttonAction(){
        if let presenter = presentingViewController as? WalletDetailsVC {
            presenter.presenter.setWallet()
            presenter.reloadCollection()
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(viewLabel)
        view.addSubview(walletLabel)
        view.addSubview(button)
        view.addSubview(collectionView)
        
        setupconstraint()
        presenter.setBackground()
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupconstraint(){
        let scaleWidth = view.bounds.width/414
        //let scaleHeight = view.bounds.height/875
        //let const20 = view.bounds.height*20/791
        let const30 = view.bounds.height*30/791
        let const40 = view.bounds.height*35/791
        let const75 = view.bounds.height*75/791
        
        viewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        walletLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        walletLabel.widthAnchor.constraint(equalToConstant: 160*scaleWidth).isActive = true
        walletLabel.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: 90*scaleWidth).isActive = true
        walletLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        button.centerYAnchor.constraint(equalTo: walletLabel.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: const40).isActive = true
        button.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: const30).isActive = true
        button.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: const40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -const30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewLabel)
    }

    func reloadCollection(){
        presenter.getTransactions()
        collectionView.reloadData()
     }

}

extension AllTransactionsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.arrayOfAllTransactions?.count ?? 0
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

        return CGSize(width: 380*scaleWidth, height: 82*scaleHeight)
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.openTransactionDetailsVC(indexPath: indexPath)
    }

}

extension AllTransactionsVC: AllTransactionsViewProtocol {
    func setBackground(wallet: NSManagedObject?) {
        guard let walletBackground = wallet?.value(forKeyPath: "colorScheme") as? String else { return }
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
