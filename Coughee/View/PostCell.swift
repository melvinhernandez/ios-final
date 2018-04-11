//
//  PostCell.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class PostCell: BasePostCell {
    
    override func setupViews() {
        backgroundColor = .gray
//        addSubview(backgroundImageView)
//        addSubview(content)
//
//        content.addSubview(titleText)
//        content.addSubview(descriptionText)
//
//        backgroundImageView.image = UIImage(named: "fsm")
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//
//        addConstraintsWithFormat(format: "H:|[v0]|", views: backgroundImageView)
//        addConstraintsWithFormat(format: "V:|[v0]|", views: backgroundImageView)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
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
