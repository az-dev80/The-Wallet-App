//
//  CurrencyVC.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 2.10.21.
//

import UIKit

class CurrencyVC: UIViewController {
    var presenter: CurrencyViewPresenterProtocol!
    var currencyCodeSelected = ""
    var const75 = CGFloat()
    var const20 = CGFloat()
    var const30 = CGFloat()
    var const40 = CGFloat()
    
    private let viewLabel:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        return aview
    }()
    
    private let walletLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wallet currency"
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
    
    lazy var tableViewCurrency:UITableView = {
        let tvg = UITableView(frame: CGRect.zero, style: .plain)
        tvg.backgroundColor = .clear
        tvg.isScrollEnabled = true
        tvg.translatesAutoresizingMaskIntoConstraints = false
        tvg.dataSource = self
        tvg.delegate = self
        tvg.separatorStyle = .none
        
        return tvg
    }()
    
    @objc func buttonAction(){
        if let presenter = presentingViewController as? AddNewWalletVC {
            presenter.setTextCurrency(forCode: currencyCodeSelected)
            //OPTION 2
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        }
        
        if let presenter = presentingViewController as? ChangeWalletVC {
            presenter.setTextCurrency(forCode: currencyCodeSelected)
        }

        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Rectangle")!)
        view.addSubview(viewLabel)
        view.addSubview(walletLabel)
        view.addSubview(button)
        view.addSubview(tableViewCurrency)
        
        if let presenter = presentingViewController as? AddNewWalletVC {
            const75 = presenter.const75
            const20 = presenter.const20
            const30 = presenter.const30
            const40 = presenter.const40
        } else {
            const20 = view.bounds.height*20/791
            const30 = view.bounds.height*30/791
            const40 = view.bounds.height*35/791
            const75 = view.bounds.height*75/791
        }
        
        tableViewCurrency.register(CurrencyVCCell.self, forCellReuseIdentifier: "cell")

        setupView()
    }
    
//    func setBorderGradientAndShadow(viewL:UIView){
//        let gradient = CAGradientLayer()
//        gradient.frame =  CGRect(origin: CGPoint.zero, size: viewL.frame.size)
//        gradient.colors = [UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.40).cgColor, UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.15).cgColor]
//        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
//        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
//        gradient.locations = [0, 1]
//        gradient.cornerRadius = 20
//        gradient.cornerCurve = .continuous
//        
//        let shape = CAShapeLayer()
//        shape.lineWidth = 3
//        shape.path = UIBezierPath(roundedRect: viewL.bounds, cornerRadius: 20).cgPath
//        
//        shape.strokeColor = UIColor.black.cgColor
//        shape.fillColor = UIColor.clear.cgColor
//        gradient.mask = shape
//        
//        viewL.layer.addSublayer(gradient)
//        
//        viewL.layer.shadowPath = shape.path
//        viewL.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
//        viewL.layer.shadowOpacity = 1
//        viewL.layer.shadowRadius = 100
//        viewL.layer.shadowOffset = CGSize(width: 5, height: 5)
//    }
    
    func setupView(){
        setupconstraint()
    }
    
    func setupconstraint(){
        
        let const17w = view.bounds.width*17/414
        
        viewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const17w).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        walletLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        walletLabel.widthAnchor.constraint(equalToConstant: view.bounds.width*206/414).isActive = true
        walletLabel.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: view.bounds.width*90/414).isActive = true
        walletLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        button.centerYAnchor.constraint(equalTo: walletLabel.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: const40).isActive = true
        button.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: const30).isActive = true
        button.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        tableViewCurrency.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: const40 - 20).isActive = true
        tableViewCurrency.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const17w).isActive = true
        tableViewCurrency.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const17w).isActive = true
        tableViewCurrency.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension CurrencyVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Locale.commonISOCurrencyCodes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! CurrencyVCCell

        let code = Locale.commonISOCurrencyCodes[indexPath.section]
        cell.currencyCode.text = code
        cell.currencyName.text = Locale.current.localizedString(forCurrencyCode: code)
        cell.backgroundColor = .clear
        
        let aview = GradientBG(frame: cell.frame)
        aview.clipsToBounds = true
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: aview)
        cell.backgroundView = aview
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return const75
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView()
        sectionHeaderView.backgroundColor = .clear
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CurrencyVCCell
        cell.selectionStyle = .none
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        currencyCodeSelected = cell.currencyCode.text!
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CurrencyVCCell
        cell.transform = .identity
     }
    
}

extension CurrencyVC: CurrencyViewProtocol {
    func success() {
        //collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}
