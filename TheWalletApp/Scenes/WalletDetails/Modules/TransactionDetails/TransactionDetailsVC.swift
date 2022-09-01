//
//  TransactionDetailsVC.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 15.10.21.
//

import UIKit
import CoreData

class TransactionDetailsVC: UIViewController {
    
    var presenter: TransactionDetailsViewPresenterProtocol!

    private let viewLabel:UIView = GradientBG(frame: .zero)
    private let viewStack:UIView  = GradientBG(frame: .zero)
    private let viewNote:UIView = GradientBG(frame: .zero)
    private var viewDeleteButton:UIView = UIView()
    
    private let headLabel:UILabel = UILabel()
    private let labelType:UILabel = UILabel()
    private let labelChange:UILabel = UILabel()
    private let labelNote:UILabel = UILabel()
    private let labelNoteValue:UILabel = UILabel()
    
    private let button: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "addNewWallet"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return bt
    }()
    
    private let buttonChange: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "buttonChange"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonChangeAction), for: .touchUpInside)
        
        return bt
    }()
    
    private let buttonDelete: UIButton = {
        let bt = UIButton()
        bt.setTitle("Delete", for: .normal)
        bt.setTitleColor(UIColor(red: 0.843, green: 0.149, blue: 0.22, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 20)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonDeleteAction), for: .touchUpInside)

        
        return bt
    }()
    
    @objc func buttonAction(){
        if let presenter = presentingViewController as? WalletDetailsVC {
            presenter.presenter.setWallet()
            presenter.reloadCollection()
        }
        if let presenter = presentingViewController as? AllTransactionsVC {
            presenter.reloadCollection()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonChangeAction(){
        presenter.openChangeTransactionVC()
    }
    
    @objc func buttonDeleteAction(){
        presenter.deleteThisTransaction()
        
        if let presenter = presentingViewController as? AllTransactionsVC {
            presenter.reloadCollection()
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setBackground()
        
        setViews(aview: viewLabel)
        setViews(aview: viewStack)
        setViews(aview: viewNote)
        viewDeleteButton = configureViewForButtons()
        view.addSubview(viewDeleteButton)
        
        setLabels(label: headLabel, fontSize: 24, color: .black)
        setLabels(label: labelType, fontSize: 28, color: .black)
        setLabels(label: labelChange, fontSize: 33, color: UIColor(red: 0.843, green: 0.149, blue: 0.22, alpha: 1))
        setLabels(label: labelNote, fontSize: 24, color: .black)
        labelNoteValue.numberOfLines = 0
        
        
        labelNoteValue.lineBreakMode = .byWordWrapping
        setLabels(label: labelNoteValue, fontSize: 18, color: .black)
        
        view.addSubview(button)
        view.addSubview(buttonChange)
        view.addSubview(buttonDelete)
        
        setupconstraint()
        
        presenter.setLabelText()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewLabel)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewStack)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewNote)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewDeleteButton, radius: view.bounds.height*35/1750)
    }
    
    func setupconstraint() {
        let scaleWidth = view.bounds.width/414
        let scaleHeight = view.bounds.height/875
        //let const20 = view.bounds.height*20/791
        let const30 = view.bounds.height*30/791
        let const40 = view.bounds.height*35/791
        let const75 = view.bounds.height*75/791
        
        viewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        button.centerYAnchor.constraint(equalTo: viewLabel.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: const40).isActive = true
        button.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: const30).isActive = true
        button.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        headLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        headLabel.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: 90*scaleWidth).isActive = true
        headLabel.trailingAnchor.constraint(equalTo: viewLabel.trailingAnchor, constant: -const30).isActive = true
        headLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        viewStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -const30).isActive = true
        viewStack.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: const40).isActive = true
        viewStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        
        labelType.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 40*scaleHeight).isActive = true
        labelType.heightAnchor.constraint(equalToConstant: 40*scaleHeight).isActive = true
        labelType.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor, constant: 30*scaleWidth).isActive = true
        labelType.widthAnchor.constraint(equalToConstant: 200*scaleWidth).isActive = true
        
        buttonChange.centerYAnchor.constraint(equalTo: labelType.centerYAnchor).isActive = true
        buttonChange.widthAnchor.constraint(equalToConstant: const40).isActive = true
        buttonChange.trailingAnchor.constraint(equalTo: viewStack.trailingAnchor, constant: -27*scaleWidth).isActive = true
        buttonChange.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        labelChange.topAnchor.constraint(equalTo: viewStack.topAnchor, constant: 117*scaleHeight).isActive = true
        labelChange.heightAnchor.constraint(equalToConstant: 30*scaleHeight).isActive = true
        labelChange.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor, constant: 30*scaleWidth).isActive = true
        labelChange.widthAnchor.constraint(equalToConstant: 160*scaleWidth).isActive = true
        
        viewNote.topAnchor.constraint(equalTo: labelChange.bottomAnchor, constant: 45*scaleHeight).isActive = true
        viewNote.centerXAnchor.constraint(equalTo: viewStack.centerXAnchor).isActive = true
        viewNote.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor, constant: 28*scaleWidth).isActive = true
        viewNote.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -90*scaleHeight).isActive = true
        
        labelNote.topAnchor.constraint(equalTo: viewNote.topAnchor, constant: 30*scaleHeight).isActive = true
        labelNote.heightAnchor.constraint(equalToConstant: 22*scaleHeight).isActive = true
        labelNote.leadingAnchor.constraint(equalTo: viewNote.leadingAnchor, constant: 20*scaleWidth).isActive = true
        labelNote.widthAnchor.constraint(equalToConstant: 70*scaleWidth).isActive = true
        
        labelNoteValue.topAnchor.constraint(equalTo: viewNote.topAnchor, constant: 72*scaleHeight).isActive = true
        labelNoteValue.centerXAnchor.constraint(equalTo: viewNote.centerXAnchor).isActive = true
        labelNoteValue.leadingAnchor.constraint(equalTo: viewNote.leadingAnchor, constant: 20*scaleWidth).isActive = true
        //labelNoteValue.bottomAnchor.constraint(equalTo: viewNote.bottomAnchor, constant: -34*scaleHeight).isActive = true
        labelNoteValue.bottomAnchor.constraint(lessThanOrEqualTo: viewNote.bottomAnchor, constant: -34*scaleHeight).isActive = true
        
        viewDeleteButton.heightAnchor.constraint(equalToConstant: 40*scaleHeight).isActive = true
        viewDeleteButton.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -30*scaleHeight).isActive = true
        viewDeleteButton.centerXAnchor.constraint(equalTo: viewStack.centerXAnchor).isActive = true
        viewDeleteButton.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor, constant: 125*scaleWidth).isActive = true
        
        buttonDelete.heightAnchor.constraint(equalToConstant: 40*scaleHeight).isActive = true
        buttonDelete.bottomAnchor.constraint(equalTo: viewStack.bottomAnchor, constant: -30*scaleHeight).isActive = true
        buttonDelete.centerXAnchor.constraint(equalTo: viewStack.centerXAnchor).isActive = true
        buttonDelete.leadingAnchor.constraint(equalTo: viewStack.leadingAnchor, constant: 125*scaleWidth).isActive = true
    }
    
    func setLabels(label: UILabel, fontSize: CGFloat, color: UIColor){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = color
        label.font = UIFont(name: "Montserrat-SemiBold", size: fontSize)
        view.addSubview(label)
    }
    
    func setViews(aview:UIView){
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        aview.layer.cornerRadius = 20
        view.addSubview(aview)
    }

    func configureViewForButtons() -> UIView {
        let aview = GradientBG(frame: .zero, rad: view.bounds.height*35/1750)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.layer.cornerRadius = view.bounds.height*35/1750
        aview.clipsToBounds = true
        return aview
    }
}

extension TransactionDetailsVC: TransactionDetailsViewProtocol {
    func setLabelText(fullDate: String, transactionType: String, amount: String, note: String) {
        headLabel.text = fullDate
        labelType.text = transactionType
        labelChange.text = amount
        labelNote.text = "Note"
        labelNoteValue.text = note
    }
    
    func setBackground(wallet: NSManagedObject?) {
        guard let walletBackground = wallet?.value(forKeyPath: "colorScheme") as? String else { return }
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: walletBackground)?.draw(in: view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image!)
        view.contentMode = .bottom
    }
    
    
}
