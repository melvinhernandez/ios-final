//
//  CoffeeShopCell.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class CoffeeShopCell: BaseCell {
    
    let backgroundImageView: UIImageView = {
        let bg = UIImageView()
        bg.contentMode = .scaleAspectFill
        bg.clipsToBounds = true
        return bg
    }()
    
    let content: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        return overlay
    }()
    
    let titleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .gray
        
        addSubview(backgroundImageView)
        // Background image constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImageView)
        
        
        addSubview(content)
        // Content constraints
        addConstraintsWithFormat(format: "H:|[v0]|", views: content)
        addConstraintsWithFormat(format: "V:|[v0]|", views: content)
        
        content.addSubview(titleText)
        // Coffee Shop name constraints
        titleText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleText.leadingAnchor.constraint(equalTo: content.safeAreaLayoutGuide.leadingAnchor),
            titleText.trailingAnchor.constraint(equalTo: content.safeAreaLayoutGuide.trailingAnchor),
            titleText.heightAnchor.constraint(equalToConstant: 32),
            titleText.centerYAnchor.constraint(equalTo: content.safeAreaLayoutGuide.centerYAnchor)
            ])
        
        content.addSubview(descriptionText)
        // Description constraints
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionText.leadingAnchor.constraint(equalTo: content.safeAreaLayoutGuide.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: content.safeAreaLayoutGuide.trailingAnchor),
            descriptionText.heightAnchor.constraint(equalToConstant: 20),
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10)
            ])
    
        
        
    }
    
}

class BaseCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .blue
    }
}

