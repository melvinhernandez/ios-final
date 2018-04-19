//
//  CreatePostViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/18/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    let createPostBtn: UIButton = {
        let button = UIButton(type: .system) // let preferred over var here
        button.setTitle("Create", for: [])
        button.addTarget(self, action: #selector(handleCreatePost), for: UIControlEvents.touchUpInside)
        button.backgroundColor = Colors.darkPastelBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(createPostBtn)
        
        let btnConstraints = [
            createPostBtn.heightAnchor.constraint(equalToConstant: 25),
            createPostBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createPostBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createPostBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(btnConstraints)
    }
    
    @objc func handleCreatePost() {
        self.dismiss(animated: true, completion: nil)
    }
}
