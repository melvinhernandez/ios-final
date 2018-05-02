//
//  LoginCoordinator.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/4/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation
import ILLoginKit
import FirebaseAuth
import FirebaseDatabase

class LoginCoordinator: ILLoginKit.LoginCoordinator {
    
    let dbRef = Database.database().reference()
    
    // Login coordinator.
    
    override func start(animated: Bool = true) {
        configureAppearance() // Configure before calling super
        super.start(animated: animated)
    }
    
    override func finish(animated: Bool = true) {
        super.finish(animated: animated)
        
    }
    
    // Login Kit Appearance Setup
    
    func configureAppearance() {
        configuration = DefaultConfiguration(backgroundImage: #imageLiteral(resourceName: "Background"),
                                             tintColor: UIColor(red: 246/255, green: 185/255, blue: 59/255, alpha: 1.0),
                                             errorTintColor: UIColor(red: 246/255, green: 185/255, blue: 59/255, alpha: 1.0),
                                             signupButtonText: "Create Account",
                                             loginButtonText: "Sign In",
                                             facebookButtonText: "Login with Facebook",
                                             forgotPasswordButtonText: "Forgot password?",
                                             recoverPasswordButtonText: "Recover",
                                             emailPlaceholder: "E-Mail",
                                             passwordPlaceholder: "Password!",
                                             repeatPasswordPlaceholder: "Confirm password!",
                                             namePlaceholder: "Name",
                                             shouldShowSignupButton: false,
                                             shouldShowLoginButton: true,
                                             shouldShowFacebookButton: false,
                                             shouldShowForgotPassword: true)
        
        configuration = Settings.defaultLoginConfig
        configuration.backgroundImage = #imageLiteral(resourceName: "Background")
        // Green-gray-ish background color for login modal.
        configuration.tintColor = UIColor(red:0.35, green:0.39, blue:0.32, alpha:1.0)
    }
    
    // Called on login tap
    override func login(email: String, password: String) {
        // Handle login via your API
        print("Login with: email =\(email) password = \(password)")
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                print("Success! Welcome!")
                self.finish()
            } else {
                // TODO: Better login error handling.
                print("lol error login")
                print(error!)
            }
        }
    }
    
    // Called on signup tap
    override func signup(name: String, email: String, password: String) {
        // Handle signup via your API
        print("Signup with: name = \(name) email =\(email) password = \(password)")
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil, user != nil {
                let changeRequest = user!.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges() { (error) in
                    if error == nil {
                        self.assignRandomImage(signupUser: user)
                        self.finish()
                    } else {
                        print("There was an error!")
                    }
                }
            } else {
                // TODO: Better signup error handling.
                print(error!)
            }
        }
    }
    
    func assignRandomImage(signupUser: User?) {
        if let user = signupUser {
            let randomImg = getRandomImage()
            let ref = dbRef.child("Users").child(user.uid).child("Image")
            ref.setValue(String(describing: randomImg))
        }
    }
    
    // I don't know if this will eventually be useful so I'll just comment it out.
//    override func enterWithFacebook(profile: FacebookProfile) {
//        // Handle Facebook login/signup via your API
//        print("Login/Signup via Facebook with: FB profile =\(profile)")
//
//    }
    
    // Called on password recovery
    // TODO: Handle using the firebase API
    override func recoverPassword(email: String) {
        print("Recover password with: email =\(email)")
    }
    
}

enum Settings {
    
    static let defaultLoginConfig = DefaultConfiguration(backgroundImage: #imageLiteral(resourceName: "Background"),
                                                         tintColor: UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1),
                                                         errorTintColor: UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1),
                                                         signupButtonText: "Create Account",
                                                         loginButtonText: "Sign In",
                                                         facebookButtonText: "Login with Facebook",
                                                         forgotPasswordButtonText: "Forgot password?",
                                                         recoverPasswordButtonText: "Recover",
                                                         emailPlaceholder: "E-Mail",
                                                         passwordPlaceholder: "Password!",
                                                         repeatPasswordPlaceholder: "Confirm password!",
                                                         namePlaceholder: "Name",
                                                         shouldShowSignupButton: true,
                                                         shouldShowLoginButton: true,
                                                         shouldShowFacebookButton: false,
                                                         shouldShowForgotPassword: true)
    
}

