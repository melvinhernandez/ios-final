//
//  CreatePostViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/18/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    var menuItem: MenuItem?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Post"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemImage: UIImageView = {
        let container = UIImageView()
        container.contentMode = .scaleAspectFill
        container.image = UIImage(named: "mocha")
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        label.text = "Americano"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let createPostBtn: UIButton = {
        let button = UIButton(type: .system) // let preferred over var here
        button.setTitle("Create", for: [])
        button.addTarget(self, action: #selector(handleCreatePost), for: UIControlEvents.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(itemImage)
        view.addSubview(itemName)
        
        let titleConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 86),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let itemImageConstraints = [
            itemImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 52),
            itemImage.heightAnchor.constraint(equalToConstant: 75),
            itemImage.widthAnchor.constraint(equalToConstant: 75)
        ]
        
        let itemNameConstraints = [
            itemName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            itemName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            itemName.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 8),
            itemName.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(itemImageConstraints)
        NSLayoutConstraint.activate(itemNameConstraints)
        
        
        
//        let btnConstraints = [
//            createPostBtn.heightAnchor.constraint(equalToConstant: 25),
//            createPostBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            createPostBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            createPostBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ]
//        NSLayoutConstraint.activate(btnConstraints)
    }
    
    @objc func handleCreatePost() {
        self.dismiss(animated: true, completion: nil)
    }
}
