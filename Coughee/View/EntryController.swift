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
    
    let appImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "entry-bg")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBackground()
    }
    
    func setupBackground() {
        self.view.addSubview(appImg)
        
        let imgCons = [
            appImg.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            appImg.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            appImg.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            appImg.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ]
        
        NSLayoutConstraint.activate(imgCons)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if isLoggedIn() {
            let entry = CustomTabBarController()
            present(entry, animated: true, completion: nil)
        } else {
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
