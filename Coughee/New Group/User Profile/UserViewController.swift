//
//  UserViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/18/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import GoogleMaps
import FontAwesome_swift

class UserViewController: UIViewController {
    
    let currentUser = CurrentUser()
    
  
    
    let bottomContainer: UserContent = {
        let container = UserContent()
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.gray
        navigationItem.title = currentUser.username
        setupContent()
    }
    
    
    func setupContent() {
        bottomContainer.delegate = self
        self.view.addSubview(bottomContainer)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomContainer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            bottomContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
    }
    
    @objc func createNewPost() {
        let newPostView = CreatePostViewController()
        self.present(newPostView, animated: true, completion: nil)
    }
    
}

extension UserViewController: UserNewPostDelegate {
    
    func showNewPostModal(menuItem: MenuItem) {
        let createNewPost = CreatePostViewController()
        createNewPost.menuItem = menuItem
        self.present(createNewPost, animated: true, completion: nil)
    }
}
