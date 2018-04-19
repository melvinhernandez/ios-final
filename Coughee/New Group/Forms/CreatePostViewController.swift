//
//  CreatePostViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/18/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import Eureka

class CreatePostViewController: FormViewController {
    
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
//        createPostForm()
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
    
    // Create form with Eureka
    func createPostForm() {
        form +++ Section("Section1")
            <<< TextRow("caption") { row in
                row.title = "Caption"
                row.placeholder = "What's poppin'"
            }
    }
    
    @objc func handleCreatePost() {
        self.dismiss(animated: true, completion: nil)
    }
}
