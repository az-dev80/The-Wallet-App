//
//  CurrencyVCCell.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 5.10.21.
//

import UIKit

class CurrencyVCCell: UITableViewCell {
    
    var currencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.backgroundColor = .clear
        return label
    }()
    
    var currencyCode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.027, green: 0.063, blue: 0.075, alpha: 1)
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(currencyName)
        contentView.addSubview(currencyCode)
        let scale = contentView.bounds.width/380
        
        currencyName.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        currencyName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currencyName.widthAnchor.constraint(equalToConstant: 240*scale).isActive = true
        currencyName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30*scale).isActive = true
        
        currencyCode.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26*scale).isActive = true
        currencyCode.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currencyCode.widthAnchor.constraint(equalToConstant: 54*scale).isActive = true
        currencyCode.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
