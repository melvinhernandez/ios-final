//
//  EntryController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/11/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import FirebaseAuth
import ILLoginKit

// This file will just act as the mediator between ILLoginKit and our app.
class EntryController: UIViewController {
    
    lazy var loginCoordinator: LoginCoordinator = {
        return LoginCoordinator(rootViewController: self)
    }()
    
    lazy var loginViewController: OverridenLoginViewController = {
        let controller = OverridenLoginViewController()
        controller.delegate = self as? LoginViewControllerDelegate
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if isLoggedIn() {
            let entry = CustomTabBarController()
            present(entry, animated: true, completion: nil)
            print("hello")
        } else {
            print("is logged in")
            loginCoordinator.start()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    fileprivate func isLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
}
