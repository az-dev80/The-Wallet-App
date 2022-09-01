//
//  AddNewWalletVC.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 2.10.21.
//

import UIKit
import CoreData

class AddNewWalletVC: UIViewController, UITextFieldDelegate {
    var presenter: AddWalletViewPresenterProtocol!

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
        label.text = "Add new wallet"
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
    
    private let viewColorTheme:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        
        return aview
    }()
    
    private let colorThemeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Color theme"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        return label
    }()
    
    private let viewColorThemeWhiteBGgrad:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        aview.layer.cornerRadius = 20

        return aview
    }()
    
    private let colorTheme: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "Rectangle")!
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let viewCurrency:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.layer.cornerRadius = 20
        aview.clipsToBounds = true
        
        return aview
    }()
    
    private let currencyLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Currency"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        return label
    }()
    
    private let viewCurrencyButton:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.layer.cornerRadius = 20
        aview.clipsToBounds = true

        return aview
    }()
    
    private let currencyButton: UIButton = {

        let bt = UIButton()
        bt.setTitle("USD $", for: .normal)
        bt.contentHorizontalAlignment = .left
        bt.setTitleColor(UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(chooseCurrency), for: .touchUpInside)
        
        return bt
    }()
    
    private let viewTitle:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.layer.cornerRadius = 20
        aview.clipsToBounds = true

        return aview
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        return label
    }()
    
    private let titleInput:UITextField = {
        let gni = UITextField()
        gni.attributedPlaceholder = NSAttributedString(string: "Start here...",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        gni.translatesAutoresizingMaskIntoConstraints = false
        gni.textAlignment = .left
        gni.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        gni.textColor = .black
        
        gni.layer.borderWidth = 1
        gni.layer.cornerRadius = 20
        gni.layer.borderColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1).cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 60))
        gni.leftView = paddingView
        gni.leftViewMode = .always
        
        //gni.becomeFirstResponder()
        let desiredPosition = gni.beginningOfDocument
        gni.selectedTextRange = gni.textRange(from: desiredPosition, to: desiredPosition)
        
        return gni
    }()
    
    @objc func buttonAction(){
        presenter.saveWallet(name: titleInput.text ?? "")
        if let presenter = presentingViewController as? ViewController {
            presenter.reloadCollection()
            print(presenter.wallets)
            //OPTION 2
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func chooseCurrency(){
        presenter.showCurrencyVC()
    }
    
    @objc func setTextCurrency(forCode: String){
        presenter.setCurrencyText(button: currencyButton, code: forCode)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        presenter.showColorVC()
    }
    
    @objc func setColorTheme(color: String){
        presenter.setColor(forImageView: colorTheme, color: color)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //OPTION 2 to get currency code
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(setTextCurrency),
//                                               name: NSNotification.Name(rawValue: "refresh"),
//                                               object: nil)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Rectangle")!)
        currencyButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        colorTheme.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
        
        setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewLabel)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewColorTheme)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewColorThemeWhiteBGgrad)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewCurrency)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewCurrencyButton)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewTitle)
//        setBorderGradientAndShadow(viewL: viewLabel, shadowOffset: CGSize(width: 5, height: 5), shadowLineWidth: 2)
//        setBorderGradientAndShadow(viewL: viewColorTheme, shadowOffset: CGSize(width: 10, height: 10), shadowLineWidth: 3)
//        setBorderGradientAndShadow(viewL: viewColorThemeWhiteBGgrad, shadowOffset: CGSize(width: 5, height: 5), shadowLineWidth: 2)
//        setBorderGradientAndShadow(viewL: viewCurrency, shadowOffset: CGSize(width: 5, height: 5), shadowLineWidth: 2)
//        setBorderGradientAndShadow(viewL: viewCurrencyButton, shadowOffset: CGSize(width: 5, height: 5), shadowLineWidth: 2)
//        setBorderGradientAndShadow(viewL: viewTitle, shadowOffset: CGSize(width: 5, height: 5), shadowLineWidth: 2)
    }
    
//    func setBorderGradientAndShadow(viewL:UIView, shadowOffset: CGSize, shadowLineWidth: CGFloat){
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
//        shape.lineWidth = shadowLineWidth
//        shape.path = UIBezierPath(roundedRect: viewL.bounds, cornerRadius: 20).cgPath
//
//        shape.strokeColor = UIColor.black.cgColor
//        shape.fillColor = UIColor.clear.cgColor
//        gradient.mask = shape
//
//        viewL.layer.addSublayer(gradient)
//
//        //let shadowPath = UIBezierPath(roundedRect: aview.bounds, cornerRadius: 20)
//
//        viewL.layer.shadowPath = shape.path
//        viewL.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
//        viewL.layer.shadowOpacity = 1
//        viewL.layer.shadowRadius = 100
//        viewL.layer.shadowOffset = shadowOffset
//    }
    
    func setupView(){
        view.addSubview(viewLabel)
        view.addSubview(walletLabel)
        view.addSubview(button)
        
        view.addSubview(viewColorTheme)
        view.addSubview(colorThemeLabel)
        view.addSubview(viewColorThemeWhiteBGgrad)
        view.addSubview(colorTheme)
        
        view.addSubview(viewCurrency)
        view.addSubview(currencyLabel)
        view.addSubview(viewCurrencyButton)
        view.addSubview(currencyButton)
        
        view.addSubview(viewTitle)
        view.addSubview(titleLabel)
        view.addSubview(titleInput)
        
        titleInput.delegate = self
        hideWhenTappedAround()
        
        setupconstraint()
    }
    
    func setupconstraint(){
        let const17w = view.bounds.width*17/414
        const20 = view.bounds.height*20/791
        let const22 = view.bounds.height*20/791
        const30 = view.bounds.height*30/791
        const40 = view.bounds.height*35/791
        let const62 = view.bounds.height*60/791
        const75 = view.bounds.height*75/791
        let const157 = view.bounds.height*155/791
        let const262 = view.bounds.height*260/791
        
        viewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const17w).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        walletLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        walletLabel.widthAnchor.constraint(equalToConstant: view.bounds.width*193/414).isActive = true
        walletLabel.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: view.bounds.width*90/414).isActive = true
        walletLabel.heightAnchor.constraint(equalToConstant: view.bounds.height*75/791).isActive = true
        
        button.topAnchor.constraint(equalTo: walletLabel.topAnchor, constant: view.bounds.height*18/791).isActive = true
        button.widthAnchor.constraint(equalToConstant: const40).isActive = true
        button.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: const30).isActive = true
        button.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        viewColorTheme.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: const40).isActive = true
        viewColorTheme.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewColorTheme.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const17w).isActive = true
        viewColorTheme.heightAnchor.constraint(equalToConstant: const262).isActive = true
        
        colorThemeLabel.topAnchor.constraint(equalTo: viewColorTheme.topAnchor, constant: const30).isActive = true
        colorThemeLabel.widthAnchor.constraint(equalToConstant: view.bounds.width*154/414).isActive = true
        colorThemeLabel.leadingAnchor.constraint(equalTo: viewColorTheme.leadingAnchor, constant: const30).isActive = true
        colorThemeLabel.heightAnchor.constraint(equalToConstant: const22).isActive = true
        
        viewColorThemeWhiteBGgrad.bottomAnchor.constraint(equalTo: viewColorTheme.bottomAnchor, constant: -const30).isActive = true
        viewColorThemeWhiteBGgrad.topAnchor.constraint(equalTo: viewColorTheme.topAnchor, constant: view.bounds.height*72/791).isActive = true
        viewColorThemeWhiteBGgrad.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewColorThemeWhiteBGgrad.leadingAnchor.constraint(equalTo: viewColorTheme.leadingAnchor, constant: const30).isActive = true
        
        colorTheme.topAnchor.constraint(equalTo: viewColorThemeWhiteBGgrad.topAnchor, constant: const30).isActive = true
        colorTheme.bottomAnchor.constraint(equalTo: viewColorThemeWhiteBGgrad.bottomAnchor, constant: -const30).isActive = true
        colorTheme.leadingAnchor.constraint(equalTo: viewColorThemeWhiteBGgrad.leadingAnchor, constant: const30).isActive = true
        colorTheme.trailingAnchor.constraint(equalTo: viewColorThemeWhiteBGgrad.trailingAnchor, constant: -view.bounds.width*37/414).isActive = true
        
        viewCurrency.topAnchor.constraint(equalTo: viewColorTheme.bottomAnchor, constant: const20).isActive = true
        viewCurrency.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewCurrency.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const17w).isActive = true
        viewCurrency.heightAnchor.constraint(equalToConstant: const157).isActive = true
        
        currencyLabel.topAnchor.constraint(equalTo: viewCurrency.topAnchor, constant: const20).isActive = true
        currencyLabel.widthAnchor.constraint(equalToConstant: view.bounds.width*113/414).isActive = true
        currencyLabel.leadingAnchor.constraint(equalTo: viewCurrency.leadingAnchor, constant: const20).isActive = true
        currencyLabel.heightAnchor.constraint(equalToConstant: const30).isActive = true
        
        viewCurrencyButton.topAnchor.constraint(equalTo: viewCurrency.topAnchor, constant: const62).isActive = true
        viewCurrencyButton.bottomAnchor.constraint(equalTo: viewCurrency.bottomAnchor, constant: -const20).isActive = true
        viewCurrencyButton.leadingAnchor.constraint(equalTo: viewCurrency.leadingAnchor, constant: const20).isActive = true
        viewCurrencyButton.trailingAnchor.constraint(equalTo: viewCurrency.trailingAnchor, constant: -const20).isActive = true
        
        currencyButton.topAnchor.constraint(equalTo: viewCurrency.topAnchor, constant: const62).isActive = true
        currencyButton.bottomAnchor.constraint(equalTo: viewCurrency.bottomAnchor, constant: -const20).isActive = true
        currencyButton.leadingAnchor.constraint(equalTo: viewCurrency.leadingAnchor, constant: const20).isActive = true
        currencyButton.trailingAnchor.constraint(equalTo: viewCurrency.trailingAnchor, constant: -const20).isActive = true
        
        viewTitle.topAnchor.constraint(equalTo: viewCurrency.bottomAnchor, constant: const20).isActive = true
        viewTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const17w).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: const157).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: viewTitle.topAnchor, constant: const20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width*54/414).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor, constant: const20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: const22).isActive = true
        
        titleInput.topAnchor.constraint(equalTo: viewTitle.topAnchor, constant: const62).isActive = true
        titleInput.bottomAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: -const20).isActive = true
        titleInput.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor, constant: const20).isActive = true
        titleInput.trailingAnchor.constraint(equalTo: viewTitle.trailingAnchor, constant: -const20).isActive = true
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func hideWhenTappedAround() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        view.addGestureRecognizer(gesture)
    }
    @objc func hide() {
        view.endEditing(true)
    }
}

extension AddNewWalletVC: AddWalletViewProtocol {
    func success() {
        //collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}
