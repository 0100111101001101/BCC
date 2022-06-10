//
//  MessageCountTableViewCell.swift
//  BCCApp
//
//  Created by Om Mandavia on 10/6/2022.
//

import UIKit

class MessageCountTableViewCell: UITableViewCell {
    
    let infoTextLabel = UILabel()       // Initialising a UI Label for the cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        infoTextLabel.textColor = .link             // setting up the content style of the cell
        infoTextLabel.numberOfLines = 0
        infoTextLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AutoLayout methods
    
    // This function adds constraints to the text label programmatically
    func setConstraints(){
        contentView.addSubview(infoTextLabel)
        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false

        // Adding contraints of 8 points on all four sides with respect to the content view
        infoTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        infoTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        infoTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        infoTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
