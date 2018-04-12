//
//  CustomTabBarController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import ILLoginKit
import FirebaseAuth

class CustomTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        print("okay???")
        super.viewDidLoad()

        let homeController = CoffeeShopsTable()
        let navigationController = UINavigationController(rootViewController: homeController)
        navigationController.tabBarItem.title = "Home"
        
        let layout = UICollectionViewFlowLayout()
        let feedController = FeedViewController(collectionViewLayout: layout)
        feedController.tabBarItem.title = "Feed"
        viewControllers = [navigationController, feedController]
    }
}
