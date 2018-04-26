//
//  PostCell.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import FontAwesome_swift

class PostCell: BasePostCell {
    
    let avatarView: UIImageView = {
        let container = UIImageView()
        container.contentMode = .scaleAspectFill
        container.image = UIImage(named: "frank")
        container.layer.cornerRadius = 25
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Frank Ocean"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1 hour ago"
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shopContainer: UIView = {
        let shopContainer = UIView()
        shopContainer.translatesAutoresizingMaskIntoConstraints = false
        return shopContainer
    }()
    
    let coffeeShopIcon: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 18)
        label.text = String.fontAwesomeIcon(code: "fa-map-marker")
        label.textColor = Colors.brownLatte
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let coffeeShopLabel: UILabel = {
        let label = UILabel()
        label.text = "Free Speech Movement Cafe"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.dirtyBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let caffeineContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let coffeeIcon: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 16)
        label.text = String.fontAwesomeIcon(code: "fa-coffee")
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let caffeineAmount: UILabel = {
        let label = UILabel()
        label.text = "333 mgs"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let menuItemName: UILabel = {
        let label = UILabel()
        label.text = "Mocha Glacier"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let leftBorder: UIView = {
        let border = UIView()
        border.backgroundColor = Colors.brownLatte
        border.translatesAutoresizingMaskIntoConstraints = false
        return border
    }()
    
    let postCaption: UILabel = {
        let caption = UILabel()
        caption.font = UIFont.systemFont(ofSize: 14)
        caption.textColor = Colors.darkGray
        caption.text = "Howdy! I just had a cup of coffee with my friend Alex G! <3"
        caption.lineBreakMode = .byWordWrapping
        caption.numberOfLines = 2
        caption.translatesAutoresizingMaskIntoConstraints = false
        return caption
    }()
    
    
    override func setupViews() {
        
        self.backgroundColor = .white
        
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(timeLabel)
        
        addSubview(caffeineContainer)
        caffeineContainer.addSubview(coffeeIcon)
        caffeineContainer.addSubview(caffeineAmount)
        addSubview(menuItemName)
        
        addSubview(textContainer)
        textContainer.addSubview(leftBorder)
        textContainer.addSubview(postCaption)
        
        addSubview(shopContainer)
        shopContainer.addSubview(coffeeShopIcon)
        shopContainer.addSubview(coffeeShopLabel)
        
        
        let imageConstraints = [
            avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            avatarView.heightAnchor.constraint(equalToConstant: 50),
            avatarView.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        let nameConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let timeConstraints = [
            timeLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
            timeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100)
        ]
        
        let menuItemNameConstraints = [
            menuItemName.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            menuItemName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            menuItemName.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
            menuItemName.topAnchor.constraint(equalTo: caffeineContainer.bottomAnchor, constant: 4)
        ]
        
        let shopContainerConstraints = [
            shopContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            shopContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            shopContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 24),
            shopContainer.topAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: 8)
        ]
        
        
        let coffeeShopNameConstraints = [
            coffeeShopLabel.leadingAnchor.constraint(equalTo: shopContainer.leadingAnchor, constant: 40),
            coffeeShopLabel.trailingAnchor.constraint(equalTo: shopContainer.trailingAnchor),
            coffeeShopLabel.topAnchor.constraint(equalTo: shopContainer.topAnchor),
            coffeeShopLabel.bottomAnchor.constraint(equalTo: shopContainer.bottomAnchor)
        ]
        
        let coffeeShopIconConstraints = [
            coffeeShopIcon.leadingAnchor.constraint(equalTo: shopContainer.leadingAnchor),
            coffeeShopIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 12),
            coffeeShopIcon.topAnchor.constraint(equalTo: shopContainer.topAnchor),
            coffeeShopIcon.bottomAnchor.constraint(equalTo: shopContainer.bottomAnchor)
        ]
        
        let caffeineConstraints = [
            caffeineContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            caffeineContainer.widthAnchor.constraint(equalToConstant: 70),
            caffeineContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
            caffeineContainer.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ]
        
        let coffeeIconConstraints = [
            coffeeIcon.leadingAnchor.constraint(equalTo: caffeineContainer.leadingAnchor),
            coffeeIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 20),
            coffeeIcon.topAnchor.constraint(equalTo: caffeineContainer.topAnchor),
            coffeeIcon.bottomAnchor.constraint(equalTo: caffeineContainer.bottomAnchor)
        ]
        
        let caffeineAmountConstraints = [
            caffeineAmount.leadingAnchor.constraint(equalTo: coffeeIcon.leadingAnchor),
            caffeineAmount.trailingAnchor.constraint(equalTo: caffeineContainer.trailingAnchor),
            caffeineAmount.topAnchor.constraint(equalTo: caffeineContainer.topAnchor),
            caffeineAmount.bottomAnchor.constraint(equalTo: caffeineContainer.bottomAnchor)
        ]
        
        let textContainerConstraints = [
            textContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            textContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            textContainer.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 8),
            textContainer.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let leftBorderConstraints = [
            leftBorder.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor),
            leftBorder.topAnchor.constraint(equalTo: textContainer.topAnchor),
            leftBorder.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor),
            leftBorder.widthAnchor.constraint(equalToConstant: 4)
        ]
        
        let postCaptionConstraints = [
            postCaption.leadingAnchor.constraint(equalTo: leftBorder.trailingAnchor, constant: 32),
            postCaption.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor),
            postCaption.topAnchor.constraint(equalTo: textContainer.topAnchor),
            postCaption.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor)
        ]
        
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(timeConstraints)
        
        NSLayoutConstraint.activate(shopContainerConstraints)
        NSLayoutConstraint.activate(coffeeShopIconConstraints)
        NSLayoutConstraint.activate(coffeeShopNameConstraints)
        
        NSLayoutConstraint.activate(caffeineConstraints)
        NSLayoutConstraint.activate(coffeeIconConstraints)
        NSLayoutConstraint.activate(caffeineAmountConstraints)
        NSLayoutConstraint.activate(menuItemNameConstraints)
        
        NSLayoutConstraint.activate(textContainerConstraints)
        NSLayoutConstraint.activate(leftBorderConstraints)
        NSLayoutConstraint.activate(postCaptionConstraints)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            print("adding constraint: \(key)")
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BasePostCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    func setupViews() {
        backgroundColor = .blue
    }
}

