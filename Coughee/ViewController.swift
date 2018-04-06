//
//  ViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/4/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import ILLoginKit
import FirebaseAuth

class ViewController: UIViewController {
    
    var hasShownLogin = false
    
    lazy var loginCoordinator: LoginCoordinator = {
        return LoginCoordinator(rootViewController: self)
    }()
    
    lazy var loginViewController: OverridenLoginViewController = {
        let controller = OverridenLoginViewController()
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard !hasShownLogin else {
            return
        }
        // If user not authenticated then show login screen.
        if Auth.auth().currentUser == nil {
            hasShownLogin = true
            loginCoordinator.start()
        } else {
            self.performSegue(withIdentifier: "welcomeToMain", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// This is just from the ILLoginKit Documentation.

extension ViewController: LoginViewControllerDelegate {
    
    func didSelectLogin(_ viewController: UIViewController, email: String, password: String) {
        print("DID SELECT LOGIN; EMAIL = \(email); PASSWORD = \(password)")
    }
    
    func didSelectForgotPassword(_ viewController: UIViewController) {
        print("LOGIN DID SELECT FORGOT PASSWORD")
    }
    
    func loginDidSelectBack(_ viewController: UIViewController) {
        print("LOGIN DID SELECT BACK")
    }
    
}
