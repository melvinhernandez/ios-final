//
//  PostCell.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class PostCell: BasePostCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Frank Ocean"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let avatarView: UIImageView = {
        let container = UIImageView()
        container.contentMode = .scaleAspectFill
        container.image = UIImage(named: "frank")
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    
    override func setupViews() {
        self.backgroundColor = .white
        addSubview(avatarView)
        addSubview(nameLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(50)]-8-[v1]|", views: avatarView, nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(50)]", views: avatarView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)

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
