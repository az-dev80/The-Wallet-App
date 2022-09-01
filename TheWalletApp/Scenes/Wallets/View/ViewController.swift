//
//  ViewController.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 24.09.21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var wallets: [NSManagedObject] = []
    var presenter: WalletsViewPresenterProtocol!
    
    let viewLabel:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.layer.cornerRadius = 20
        aview.clipsToBounds = true

        return aview
    }()
    
    let walletLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wallets"
        label.textAlignment = .left
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        return label
    }()
    
    let noWalletLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No wallets created 😥"
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.textAlignment = .center
        
        return label
    }()
    
    let button: UIButton = {
        let bt = UIButton()
        bt.setTitle("+", for: .normal)
        bt.setTitleColor(UIColor(red: 0.247, green: 0.533, blue: 0.773, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .light)
        bt.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 6, right: 0)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.layer.borderWidth = 1.5
        bt.layer.cornerRadius = 20
        bt.layer.borderColor = UIColor(red: 0.247, green: 0.533, blue: 0.773, alpha: 1).cgColor
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
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    @objc func buttonAction(){
        presenter.tapPlusButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Rectangle")!)
        //presenter.deleteAllWallets()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getWallets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewLabel)
    }
    
    func setupView(){
        view.addSubview(viewLabel)
        view.addSubview(walletLabel)
        view.addSubview(noWalletLabel)
        view.addSubview(button)
        view.addSubview(collectionView)
        setupconstraint()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupconstraint(){
        viewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        walletLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        walletLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        walletLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47).isActive = true
        walletLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        noWalletLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noWalletLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noWalletLabel.widthAnchor.constraint(equalToConstant: 290).isActive = true
        noWalletLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        button.topAnchor.constraint(equalTo: walletLabel.topAnchor, constant: 18).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: walletLabel.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant:  40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
      
    func reloadCollection(){
        presenter.getWallets()
        collectionView.reloadData()
        noWalletLabel.isHidden = true
     }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.wallets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let wallets = presenter.wallets?[indexPath.row]
        if wallets != nil {
            noWalletLabel.isHidden = true
        } else {
            self.noWalletLabel.isHidden = false
        }
        cell.title.text = wallets?.value(forKeyPath: "nameWallet") as? String
        if wallets?.value(forKeyPath: "fullDate") as? String != nil {
            cell.lastChangeValue.text = wallets?.value(forKeyPath: "fullDate") as? String
        } else {
            cell.lastChangeValue.text = "No activity"
        }
        
        let total = wallets?.value(forKeyPath: "sum") as? String
        if total != "0" {
            cell.currency.text = total
        } else {
            let code = wallets?.value(forKeyPath: "currency") as? String
            let locale = NSLocale(localeIdentifier: code ?? "USD")
            if locale.displayName(forKey: .currencySymbol, value: code ?? "USD") == code {
                cell.currency.text = "0 \(code ?? "USD")"
            }
            else {
                cell.currency.text = "0 \(locale.displayName(forKey: .currencySymbol, value: code!) ?? "$")"
            }
        }
        
        let aview = GradientBG(frame: cell.frame)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: aview)
        cell.backgroundView = aview

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding = sectionInsets.left * (itemsPerRow + 1)
        //let availableWidth = view.frame.width - padding
        //let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: view.bounds.width*380/414, height: 208)
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let wallet = (presenter.wallets?[indexPath.row])
        presenter.openWalletDetailsVC(wallet: wallet!, walletIndex: indexPath)

    }

}

extension ViewController: WalletsViewProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}
//func getSymbolForCurrencyCode(code: String) -> String {
//        var candidates: [String] = []
//        let locales: [String] = NSLocale.availableLocaleIdentifiers
//        for localeID in locales {
//            guard let symbol = findMatchingSymbol(localeID: localeID, currencyCode: code) else {
//                continue
//            }
//            if symbol.count == 1 {
//                return symbol
//            }
//            candidates.append(symbol)
//        }
//        let sorted = sortAscByLength(list: candidates)
//        if sorted.count < 1 {
//            return ""
//        }
//        return sorted[0]
//    }
//
//    func findMatchingSymbol(localeID: String, currencyCode: String) -> String? {
//        let locale = Locale(identifier: localeID as String)
//        guard let code = locale.currencyCode else {
//            return nil
//        }
//        if code != currencyCode {
//            return nil
//        }
//        guard let symbol = locale.currencySymbol else {
//            return nil
//        }
//        return symbol
//    }
//
//    func sortAscByLength(list: [String]) -> [String] {
//        return list.sorted(by: { $0.count < $1.count })
//    }
