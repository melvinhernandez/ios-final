//
//  CoffeeShopView.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/11/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import GoogleMaps
import FontAwesome_swift

class CoffeeShopViewController: UIViewController {
    
    var coffeeShop:CoffeeShop?
    
    var mapContainer:GMSMapView = {
        let container = GMSMapView()
        return container
    }()
    
    let bottomContainer: CoffeeShopContent = {
        let container = CoffeeShopContent()
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let shop = self.coffeeShop {
            navigationItem.title = shop.name
        }
//        setupMap()
        setupContent()
    }
    
    
    func setupContent() {
        bottomContainer.delegate = self
        bottomContainer.coffeeShop = self.coffeeShop
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
        print("hello")
        let newPostView = CreatePostViewController()
        self.present(newPostView, animated: true, completion: nil)
    }

}

extension CoffeeShopViewController: NewPostDelegate {
    
    func showNewPostModal(menuItem: MenuItem) {
        let createNewPost = CreatePostViewController()
        createNewPost.menuItem = menuItem
        createNewPost.coffeeShop = self.coffeeShop
        self.present(createNewPost, animated: true, completion: nil)
    }
}

