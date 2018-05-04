//
//  CustomTabBarController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

// File that handles the app's tab bar.

import UIKit
import ILLoginKit
import FirebaseAuth
import FontAwesome_swift

class CustomTabBarController: UITabBarController {

    
    let logoutButton: UIBarButtonItem = {
        let rightButtonItem = UIBarButtonItem(
            title: String.fontAwesomeIcon(code: "fa-sign-out"),
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(logoutButtonAction)
        )
        let attributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont.fontAwesome(ofSize: 20)] as [NSAttributedStringKey: Any]
        rightButtonItem.setTitleTextAttributes(attributes, for: UIControlState.normal)
        return rightButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let coffeeShopController = CoffeeShopsTable()
        let coffeeNavigationController = UINavigationController(rootViewController: coffeeShopController)
        coffeeNavigationController.navigationController?.navigationBar.tintColor = .white
        coffeeNavigationController.tabBarItem.title = "Shops"
        coffeeNavigationController.tabBarItem.image = UIImage(named: "home")
        coffeeNavigationController.tabBarItem.selectedImage = UIImage(named: "home-selected")

        
        let layout = UICollectionViewFlowLayout()
        let feedController = FeedViewController(collectionViewLayout: layout)
        let userFeedNavigationController = UINavigationController(rootViewController: feedController)
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = Colors.midPastelBlue
        navAppearance.tintColor = .white
        navAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        
        feedController.tabBarItem.title = "Feed"
        feedController.tabBarItem.image = UIImage(named: "cup")
        feedController.tabBarItem.selectedImage = UIImage(named: "cup-selected")
        feedController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 3, -3, -5)
        
        let userLayout = UICollectionViewFlowLayout()
        let userProfileController = UserViewController(collectionViewLayout: userLayout)
        let userNavigationController = UINavigationController(rootViewController: userProfileController)
        
        userProfileController.tabBarItem.title = "User"
        userProfileController.tabBarItem.image = UIImage(named: "user")
        userProfileController.tabBarItem.selectedImage = UIImage(named: "user-selected")
        userProfileController.navigationItem.rightBarButtonItem = logoutButton
        
        
        viewControllers = [coffeeNavigationController, userFeedNavigationController, userNavigationController]
        tabBar.isTranslucent = false
        tabBar.tintColor = Colors.dirtyBrown
        tabBar.barTintColor = Colors.brownLatte
        tabBar.layer.borderWidth = 0.50
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.clipsToBounds = true
    }
    
    @objc func logoutButtonAction() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

}
