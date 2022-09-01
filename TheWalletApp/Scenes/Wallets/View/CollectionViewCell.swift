//
//  CollectionViewCell.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 5.10.21.
//

import UIKit
import  CoreData

class CollectionViewCell: UICollectionViewCell {
    
    let title:UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        tl.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        tl.adjustsFontSizeToFitWidth = true
        
        return tl
    }()
    
    let currency:UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        cat.adjustsFontSizeToFitWidth = true
        cat.textAlignment = .left
        cat.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        cat.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        
        return cat
    }()
    
     let lastChangeLabel:UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        cat.textAlignment = .left
        cat.text = "Last change"
        cat.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        cat.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        
        return cat
    }()
    
    let lastChangeValue:UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        cat.adjustsFontSizeToFitWidth = true
        cat.textAlignment = .left
        cat.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        cat.font = UIFont(name: "Montserrat-Regular", size: 18)
        
        return cat
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(title)
        contentView.addSubview(currency)
        contentView.addSubview(lastChangeLabel)
        contentView.addSubview(lastChangeValue)
        contentView.layer.cornerRadius = 20
        
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        title.heightAnchor.constraint(equalToConstant: 22).isActive = true
        title.widthAnchor.constraint(equalToConstant: 158).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        currency.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        currency.heightAnchor.constraint(equalToConstant: 22).isActive = true
        currency.widthAnchor.constraint(equalToConstant: 100).isActive = true
        currency.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30).isActive = true
        
        lastChangeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        lastChangeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        lastChangeLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        lastChangeLabel.topAnchor.constraint(equalTo: currency.bottomAnchor, constant: 40).isActive = true
        
        lastChangeValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        lastChangeValue.heightAnchor.constraint(equalToConstant: 22).isActive = true
        lastChangeValue.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lastChangeValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
