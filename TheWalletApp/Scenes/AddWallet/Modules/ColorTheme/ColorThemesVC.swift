//
//  ColorThemesVC.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 2.10.21.
//

import UIKit

class ColorThemesVC: UIViewController {
    var presenter: ColorViewPresenterProtocol!
    var colorName:String = ""
    var const75 = CGFloat()
    var const20 = CGFloat()
    var const30 = CGFloat()
    var const40 = CGFloat()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private let viewLabel:UIView = {
        var aview = GradientBG(frame: .zero)
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        return aview
    }()
    
    private let walletLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Color themes"
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
    
    private let bg1view = GradientBG(frame: .zero)
    private let bg2view = GradientBG(frame: .zero)
    private let bg3view = GradientBG(frame: .zero)
    private let bg4view = GradientBG(frame: .zero)
    private let bg5view = GradientBG(frame: .zero)
    
    private let bg1 = UIImageView()
    private let bg2 = UIImageView()
    private let bg3 = UIImageView()
    private let bg4 = UIImageView()
    private let bg5 = UIImageView()
    
    func setViewAndImage(aview: UIView, iv:UIImageView, name: String, tag: Int){
        aview.translatesAutoresizingMaskIntoConstraints = false
        aview.clipsToBounds = true
        aview.layer.cornerRadius = 20
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: name)!
        iv.isUserInteractionEnabled = true
        iv.tag = tag
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
        scrollView.addSubview(aview)
        scrollView.addSubview(iv)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        colorName = "bg\(tappedImage.tag)"
        
        let array = [[bg1view,bg1],[bg2view,bg2],[bg3view,bg3],[bg4view,bg4],[bg5view,bg5]]
        presenter.scaleUnit(tappedImage: tappedImage, array: array) 
        
    }
    
    @objc func buttonAction(){
        if let presenter = presentingViewController as? AddNewWalletVC {
            presenter.setColorTheme(color: colorName)
        }
        if let presenter = presentingViewController as? ChangeWalletVC {
            presenter.setColorTheme(color: colorName)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Rectangle")!)
        view.addSubview(scrollView)
        scrollView.addSubview(viewLabel)
        scrollView.addSubview(walletLabel)
        scrollView.addSubview(button)
        setViewAndImage(aview: bg1view, iv: bg1, name: "bg1-pre", tag: 1)
        setViewAndImage(aview: bg2view, iv: bg2, name: "bg2-pre", tag: 2)
        setViewAndImage(aview: bg3view, iv: bg3, name: "bg3-pre", tag: 3)
        setViewAndImage(aview: bg4view, iv: bg4, name: "bg4-pre", tag: 4)
        setViewAndImage(aview: bg5view, iv: bg5, name: "bg5-pre", tag: 5)
        
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
        
        setupView()
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 895)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: viewLabel)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: bg1view)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: bg2view)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: bg3view)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: bg4view)
        GradientBorderAndShadow.setBorderGradientAndShadow(viewL: bg5view)
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
//        shape.lineWidth = 2
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
        let scale = view.bounds.width/414
        let const17w = view.bounds.width*17/414
        let const25 = const30/1.2
        let const160 = 160*scale
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        viewLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: const30).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        viewLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: const17w).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        walletLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: const30).isActive = true
        walletLabel.widthAnchor.constraint(equalToConstant: view.bounds.width*166/414).isActive = true
        walletLabel.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: view.bounds.width*90/414).isActive = true
        walletLabel.heightAnchor.constraint(equalToConstant: const75).isActive = true
        
        button.centerYAnchor.constraint(equalTo: walletLabel.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: const40).isActive = true
        button.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: const30).isActive = true
        button.heightAnchor.constraint(equalToConstant: const40).isActive = true
        
        bg1view.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: const40).isActive = true
        bg1view.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bg1view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: const17w).isActive = true
        bg1view.heightAnchor.constraint(equalToConstant: const160).isActive = true
        
        bg1.topAnchor.constraint(equalTo: bg1view.topAnchor, constant: const30).isActive = true
        bg1.bottomAnchor.constraint(equalTo: bg1view.bottomAnchor, constant: -const30).isActive = true
        bg1.leadingAnchor.constraint(equalTo: bg1view.leadingAnchor, constant: const25).isActive = true
        bg1.trailingAnchor.constraint(equalTo: bg1view.trailingAnchor, constant: -const25).isActive = true
        
        bg2view.topAnchor.constraint(equalTo: bg1view.bottomAnchor, constant: const30).isActive = true
        bg2view.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bg2view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: const17w).isActive = true
        bg2view.heightAnchor.constraint(equalToConstant: const160).isActive = true
        
        bg2.topAnchor.constraint(equalTo: bg2view.topAnchor, constant: const30).isActive = true
        bg2.bottomAnchor.constraint(equalTo: bg2view.bottomAnchor, constant: -const30).isActive = true
        bg2.leadingAnchor.constraint(equalTo: bg2view.leadingAnchor, constant: const25).isActive = true
        bg2.trailingAnchor.constraint(equalTo: bg2view.trailingAnchor, constant: -const25).isActive = true
        
        bg3view.topAnchor.constraint(equalTo: bg2view.bottomAnchor, constant: const30).isActive = true
        bg3view.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bg3view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: const17w).isActive = true
        bg3view.heightAnchor.constraint(equalToConstant: const160).isActive = true
        
        bg3.topAnchor.constraint(equalTo: bg3view.topAnchor, constant: const30).isActive = true
        bg3.bottomAnchor.constraint(equalTo: bg3view.bottomAnchor, constant: -const30).isActive = true
        bg3.leadingAnchor.constraint(equalTo: bg3view.leadingAnchor, constant: const25).isActive = true
        bg3.trailingAnchor.constraint(equalTo: bg3view.trailingAnchor, constant: -const25).isActive = true
        
        bg4view.topAnchor.constraint(equalTo: bg3view.bottomAnchor, constant: const30).isActive = true
        bg4view.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bg4view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: const17w).isActive = true
        bg4view.heightAnchor.constraint(equalToConstant: const160).isActive = true
        
        bg4.topAnchor.constraint(equalTo: bg4view.topAnchor, constant: const30).isActive = true
        bg4.bottomAnchor.constraint(equalTo: bg4view.bottomAnchor, constant: -const30).isActive = true
        bg4.leadingAnchor.constraint(equalTo: bg4view.leadingAnchor, constant: const25).isActive = true
        bg4.trailingAnchor.constraint(equalTo: bg4view.trailingAnchor, constant: -const25).isActive = true
        
        bg5view.topAnchor.constraint(equalTo: bg4view.bottomAnchor, constant: const30).isActive = true
        bg5view.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bg5view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: const17w).isActive = true
        bg5view.heightAnchor.constraint(equalToConstant: const160).isActive = true
        bg5view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -const30).isActive = true
        
        bg5.topAnchor.constraint(equalTo: bg5view.topAnchor, constant: const30).isActive = true
        bg5.bottomAnchor.constraint(equalTo: bg5view.bottomAnchor, constant: -const30).isActive = true
        bg5.leadingAnchor.constraint(equalTo: bg5view.leadingAnchor, constant: const25).isActive = true
        bg5.trailingAnchor.constraint(equalTo: bg5view.trailingAnchor, constant: -const25).isActive = true
    }
}

extension ColorThemesVC: ColorViewProtocol {
    func success() {
        //collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}
