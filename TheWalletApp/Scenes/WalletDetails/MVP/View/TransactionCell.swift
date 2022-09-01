//
//  TransactionCell.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 11.10.21.
//

import UIKit
import CoreData

class TransactionCell: UICollectionViewCell {
    
     let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let typeLabel:UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .black
        tl.font = UIFont(name: "Montserrat-Bold", size: 18)
        tl.adjustsFontSizeToFitWidth = true

        return tl
    }()

    let dateLabel:UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        cat.textAlignment = .left
        cat.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        cat.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        cat.adjustsFontSizeToFitWidth = true

        return cat
    }()

     let amountLabel:UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        cat.textAlignment = .left
        cat.textColor = UIColor(red: 0.843, green: 0.149, blue: 0.22, alpha: 1)
        cat.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        cat.adjustsFontSizeToFitWidth = true
        
        return cat
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImage)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(amountLabel)

        let const20 = contentView.bounds.height*20/90
        let const22 = contentView.bounds.height*22/90
        let const5 = contentView.bounds.height*6/90
        let const170w = contentView.bounds.width*170/325
        let const70w = contentView.bounds.width*70/325
        let const100w = contentView.bounds.width*90/325
        
        iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const20).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const20).isActive = true
        iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -const20).isActive = true

        typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const20).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: const20).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: const22).isActive = true
        typeLabel.widthAnchor.constraint(equalToConstant: const70w).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: const5).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: const20).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: const70w).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -const20).isActive = true
        
        amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const170w).isActive = true
        amountLabel.widthAnchor.constraint(equalToConstant: const100w).isActive = true
        amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: const22).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

