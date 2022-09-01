//
//  ChangeTransactionPresenter.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 18.10.21.
//

import UIKit
import CoreData

class ChangeTransactionVC: UIViewController, UITextFieldDelegate {

    var presenter: ChangeTransactionViewPresenterProtocol!
    var transactions: [NSManagedObject] = []
    
    var const75 = CGFloat()
    var const20 = CGFloat()
    var const30 = CGFloat()
    var const40 = CGFloat()
    
    let viewLabel:UIView = GradientBG(frame: .zero)
    private let viewType:UIView  = GradientBG(frame: .zero)
    private let viewChange:UIView = GradientBG(frame: .zero)
    private let viewNote:UIView = GradientBG(frame: .zero)
    
    private let addTransactionLabel:UILabel = UILabel()
    private let labelType:UILabel = UILabel()
    private let labelChange:UILabel = UILabel()
    private let labelNote:UILabel = UILabel()
    
    private let inputType:UITextField = UITextField()
    private let inputChange:UITextField = UITextField()
    private let inputNote:UITextField = UITextField()
    
    private let viewChangeButtons:UIView = {
        let aview = UIView()
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        aview.backgroundColor = UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.4)
        aview.layer.cornerRadius = 9
        aview.layer.borderWidth = 1
        aview.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.3).cgColor
        
        return aview
    }()
    
    private let button: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "addNewWallet"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return bt
    }()
    
    private let buttonOutcome: UIButton = {
        let bt = UIButton()
        bt.setTitle("Outcome", for: .normal)
        bt.setTitleColor(UIColor(red: 0.843, green: 0.149, blue: 0.22, alpha: 1), for: .normal)
        bt.tag = 0
        bt.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 13)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonChange), for: .touchUpInside)
        
        bt.backgroundColor = UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.4)
        bt.layer.cornerRadius = 7
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.984, alpha: 1).cgColor
        
        return bt
    }()
    
    private let buttonIncome: UIButton = {
        let bt = UIButton()
        bt.setTitle("Income", for: .normal)
        bt.setTitleColor(UIColor(red: 0.213, green: 0.667, blue: 0, alpha: 1), for: .normal)
        bt.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 13)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonChange), for: .touchUpInside)
        bt.alpha = 0.4
        bt.tag = 1
        
        return bt
    }()
    
    @objc func buttonAction(){
        presenter.updateTransaction(transactionType: inputType.text ?? "", transactionAmount: inputChange.text ?? "", transactionNote: inputNote.text ?? "", buttonState: buttonIncome.state)
        if let presenter = presentingViewController as? TransactionDetailsVC {
            presenter.presenter.updateLabelText()
        }
        if let presenter = presentingViewController as? WalletDetailsVC {
            presenter.presenter.setWallet()
            presenter.reloadCollection()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonChange(sender:UIButton){
        if sender.tag == 1 {
            setBackgroundAndBordersForButton(button: buttonIncome)
            clearBackgroundAndBordersForButton(button: buttonOutcome)
        } else {
            setBackgroundAndBordersForButton(button: buttonOutcome)
            clearBackgroundAndBordersForButton(button: buttonIncome)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setBackground()
        setViews(aview: viewLabel)
        setViews(aview: viewType)
        setViews(aview: viewChange)
        view.addSubview(viewChangeButtons)
        setViews(aview: viewNote)
        
        setLabels(label: addTransactionLabel, text: "Edit transaction")
        setLabels(label: labelType, text: "Title")
        setLabels(label: labelChange, text: "Change")
        setLabels(label: labelNote, text: "Note")
        
        setTextFields(gni: inputType)
        setTextFields(gni: inputChange)
        setTextFields(gni: inputNote)
        
        view.addSubview(button)
        view.addSubview(buttonOutcome)
        view.addSubview(buttonIncome)
       
        inputType.delegate = self
        inputChange.delegate = self
        inputNote.delegate = self
        hideWhenTappedAround()
        
        setupconstraint()
        
        presenter.setLabelText()
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
        
        addTransactionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const30).isActive = true
        addTransactionLabel.widthAnchor.constraint(equalToConstant: 200*scaleWidth).isActive = true
        addTransactionLabel.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: 90*scaleWidth).isActive = true
        addTransactionLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        button.centerYAnchor.constraint(equalTo: addTransactionLabel.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: const40).isActive = true
        button.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: const30).isActive = true
        button.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        viewType.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: const40).isActive = true
        viewType.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewType.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        viewType.heightAnchor.constraint(equalToConstant: 155*scaleHeight).isActive = true
        
        labelType.topAnchor.constraint(equalTo: viewType.topAnchor, constant: 20*scaleHeight).isActive = true
        labelType.heightAnchor.constraint(equalToConstant: 22*scaleHeight).isActive = true
        labelType.widthAnchor.constraint(equalToConstant: 54*scaleWidth).isActive = true
        labelType.leadingAnchor.constraint(equalTo: viewType.leadingAnchor, constant: 20*scaleWidth).isActive = true
        
        inputType.bottomAnchor.constraint(equalTo: viewType.bottomAnchor, constant: -20*scaleHeight).isActive = true
        inputType.topAnchor.constraint(equalTo: viewType.topAnchor, constant: 62*scaleHeight).isActive = true
        inputType.centerXAnchor.constraint(equalTo: viewType.centerXAnchor).isActive = true
        inputType.leadingAnchor.constraint(equalTo: viewType.leadingAnchor, constant: 20*scaleWidth).isActive = true
        
        viewChange.topAnchor.constraint(equalTo: viewType.bottomAnchor, constant: const20).isActive = true
        viewChange.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewChange.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        viewChange.heightAnchor.constraint(equalToConstant: 175*scaleHeight).isActive = true
        
        labelChange.topAnchor.constraint(equalTo: viewChange.topAnchor, constant: 20*scaleHeight).isActive = true
        labelChange.heightAnchor.constraint(equalToConstant: 33*scaleHeight).isActive = true
        labelChange.widthAnchor.constraint(equalToConstant: 97*scaleWidth).isActive = true
        labelChange.leadingAnchor.constraint(equalTo: viewChange.leadingAnchor, constant: 20*scaleWidth).isActive = true
        
        viewChangeButtons.topAnchor.constraint(equalTo: viewChange.topAnchor, constant: 15*scaleHeight).isActive = true
        viewChangeButtons.heightAnchor.constraint(equalToConstant: 32*scaleHeight).isActive = true
        viewChangeButtons.widthAnchor.constraint(equalToConstant: 204*scaleWidth).isActive = true
        viewChangeButtons.trailingAnchor.constraint(equalTo: viewChange.trailingAnchor, constant: -20*scaleWidth).isActive = true
        
        buttonOutcome.topAnchor.constraint(equalTo: viewChangeButtons.topAnchor, constant: 2*scaleHeight).isActive = true
        buttonOutcome.heightAnchor.constraint(equalToConstant: 28*scaleHeight).isActive = true
        buttonOutcome.widthAnchor.constraint(equalToConstant: 100*scaleWidth).isActive = true
        buttonOutcome.leadingAnchor.constraint(equalTo: viewChangeButtons.leadingAnchor, constant: 1*scaleWidth).isActive = true
        
        buttonIncome.topAnchor.constraint(equalTo: viewChangeButtons.topAnchor, constant: 2*scaleHeight).isActive = true
        buttonIncome.heightAnchor.constraint(equalToConstant: 28*scaleHeight).isActive = true
        buttonIncome.widthAnchor.constraint(equalToConstant: 100*scaleWidth).isActive = true
        buttonIncome.trailingAnchor.constraint(equalTo: viewChangeButtons.trailingAnchor, constant: -1*scaleWidth).isActive = true
        
        inputChange.bottomAnchor.constraint(equalTo: viewChange.bottomAnchor, constant: -16*scaleHeight).isActive = true
        inputChange.topAnchor.constraint(equalTo: viewChange.topAnchor, constant: 86*scaleHeight).isActive = true
        inputChange.centerXAnchor.constraint(equalTo: viewChange.centerXAnchor).isActive = true
        inputChange.leadingAnchor.constraint(equalTo: viewChange.leadingAnchor, constant: 20*scaleWidth).isActive = true
        
        viewNote.topAnchor.constraint(equalTo: viewChange.bottomAnchor, constant: const20).isActive = true
        viewNote.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewNote.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17*scaleWidth).isActive = true
        viewNote.heightAnchor.constraint(equalToConstant: 300*scaleHeight).isActive = true
        
        labelNote.topAnchor.constraint(equalTo: viewNote.topAnchor, constant: 20*scaleHeight).isActive = true
        labelNote.heightAnchor.constraint(equalToConstant: 22*scaleHeight).isActive = true
        labelNote.widthAnchor.constraint(equalToConstant: 60*scaleWidth).isActive = true
        labelNote.leadingAnchor.constraint(equalTo: viewNote.leadingAnchor, constant: 20*scaleWidth).isActive = true
        
        inputNote.bottomAnchor.constraint(equalTo: viewNote.bottomAnchor, constant: -20*scaleHeight).isActive = true
        inputNote.topAnchor.constraint(equalTo: labelNote.bottomAnchor, constant: 20*scaleHeight).isActive = true
        inputNote.centerXAnchor.constraint(equalTo: viewNote.centerXAnchor).isActive = true
        inputNote.leadingAnchor.constraint(equalTo: viewNote.leadingAnchor, constant: 20*scaleWidth).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewLabel)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewType)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewChange)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewNote)
    }
    
    func setTextFields(gni:UITextField){
        
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
        
        let desiredPosition = gni.beginningOfDocument
        gni.selectedTextRange = gni.textRange(from: desiredPosition, to: desiredPosition)
        view.addSubview(gni)
    }
    
    func setLabels(label: UILabel, text: String){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        view.addSubview(label)
    }
    
    func setViews(aview:UIView){
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        aview.layer.cornerRadius = 20
        view.addSubview(aview)
    }
    
    func setBackgroundAndBordersForButton(button:UIButton){
        button.alpha = 1.0
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.4)
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 1, green: 1, blue: 0.984, alpha: 1).cgColor

    }
    
    func clearBackgroundAndBordersForButton(button:UIButton){
        button.alpha = 0.4
        button.backgroundColor = .clear
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 0
        button.layer.borderColor = .none
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldString = textField.text, let range = Range(range, in: textFieldString) else { return false }
        let newString = textFieldString.replacingCharacters(in: range, with: string)
        if newString.isEmpty {
            textField.text = ""
            return false
        } else if textField.text == "" {
            textField.text = string
            return false
        }
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

extension ChangeTransactionVC: ChangeTransactionViewProtocol {
    func setBackground(wallet: NSManagedObject?) {
        guard let background = wallet?.value(forKeyPath: "colorScheme") as? String else { return }
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: background)?.draw(in: view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image!)
        view.contentMode = .bottom
    }
    
    func setLabelText(transactionType: String, amount: String, note: String) {
        
        inputType.text = transactionType
        
        var sum = amount
        if sum.first == "-" {
            sum.removeFirst()
        } else {
            setBackgroundAndBordersForButton(button: buttonIncome)
            clearBackgroundAndBordersForButton(button: buttonOutcome)
        }
        inputChange.text = sum
    
        if note.count > 0 {
            inputNote.text = note
        } else {
            inputNote.attributedPlaceholder = NSAttributedString(string: note,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)])
        }
    }
}
