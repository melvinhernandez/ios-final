//
//  CreatePostViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/18/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import TransitionButton
import UIKit
import SkyFloatingLabelTextField
import FirebaseDatabase

class CreatePostViewController: UIViewController, UITextFieldDelegate {
    
    var menuItem: MenuItem?
    var coffeeShop: CoffeeShop?
    
    let currentUser = CurrentUser()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Post"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemImage: UIImageView = {
        let container = UIImageView()
        container.contentMode = .scaleAspectFill
        container.image = UIImage(named: "mocha")
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        label.text = "Americano"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let formContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let shopContainer: UIView = {
        let shopContainer = UIView()
        shopContainer.translatesAutoresizingMaskIntoConstraints = false
        return shopContainer
    }()
    
    let coffeeShopIcon: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 18)
        label.text = String.fontAwesomeIcon(code: "fa-map-marker")
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let coffeeShopLabel: UILabel = {
        let label = UILabel()
        label.text = "Free Speech Movement"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let caffeineContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let coffeeIcon: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 18)
        label.text = String.fontAwesomeIcon(code: "fa-coffee")
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let caffeineAmount: UILabel = {
        let label = UILabel()
        label.text = "333 mgs"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let captionContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let captionIcon: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 18)
        label.text = String.fontAwesomeIcon(code: "fa-user")
        label.textColor = Colors.coral
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let captionTitle: UIView = {
        let label = UIView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputField: SkyFloatingLabelTextField = {
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        let textFieldFrame = CGRect(x: 0, y: 0, width: 290, height: 60)
        let textField1 = SkyFloatingLabelTextField(frame: textFieldFrame)
        textField1.placeholder = "What did you do?"
        textField1.title = "Caption"
        textField1.lineColor = Colors.coral
        textField1.tintColor = Colors.coral
        textField1.selectedTitleColor = Colors.coral
        textField1.selectedLineColor = Colors.coral
        return textField1
    }()
    
    let button: TransitionButton = {
        let button = TransitionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dismissButton: TransitionButton = {
        let button = TransitionButton()
        button.backgroundColor = Colors.lightGray
        button.setTitle("Cancel", for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(dismissForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.delegate = self
        inputField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        view.backgroundColor = .white
        setupViews()
        formSetup()
        setupButton()
        setupDismissButton()
        setupText()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func setupButton() {
        button.backgroundColor = Colors.coral
        button.setTitle("Brew Post", for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        button.disabledBackgroundColor = Colors.gray
        button.addTarget(self, action: #selector(handleFormSubmit), for: .touchUpInside)
        button.isEnabled = false
        
        view.addSubview(button)
        
        let buttonConstraints = [
            button.topAnchor.constraint(equalTo: formContainer.bottomAnchor, constant: 24),
            button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupDismissButton() {
        view.addSubview(dismissButton)
        
        let buttonConstraints = [
            dismissButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 18),
            dismissButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            dismissButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc func handleFormSubmit() {
        button.startAnimation()
        dismissButton.isHidden = true
        if let text = inputField.text {
            if text.count > 0 && text.count <= 60 {
                let timeOfPost = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = dateFormatter.string(from: timeOfPost)
                let coffeeShopName = coffeeShop?.name!
                let newPost = Post(username: currentUser.username, item: (menuItem?.name)!, shop: coffeeShopName!, caffeine: (menuItem?.caffeine)!, caption: text, dateString: dateString)
                sendPost(post: newPost)
            } else {
                print("what??")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.inputField.resignFirstResponder()
        return true
    }
    
    @objc func dismissForm() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Firebase Logic
    // Makes the request to Firebase
    func sendPost(post: Post) {
        let dbRef = Database.database().reference()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateString = dateFormatter.string(from: post.date)
        
        let postDict: [String:AnyObject] = [
                                            "username": post.username as AnyObject,
                                            "menuItem": post.item as AnyObject,
                                            "coffeeShop": post.shop as AnyObject,
                                            "caffeine": post.caffeine as AnyObject,
                                            "caption": post.caption as AnyObject,
                                            "date": dateString as AnyObject]
        
        let newPostRef = dbRef.child("Posts").childByAutoId()
        newPostRef.setValue(postDict) { (err, ref) -> Void in
            if (err != nil) {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.button.stopAnimation(animationStyle: .shake, completion: {
                        self.inputField.errorMessage = err?.localizedDescription
                    })
                })
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.button.stopAnimation(animationStyle: .expand, completion: {
                        self.dismiss(animated: true, completion: nil)
                    })
                })
            }
        }
        currentUser.addNewPost(postID: newPostRef.description())
    }
    
    // Views Logic
    
    func setupText() {
        itemName.text = menuItem?.name
        coffeeShopLabel.text = coffeeShop?.name
        caffeineAmount.text = "\((menuItem?.caffeine)!) mgs"
        itemImage.image = UIImage(named: (menuItem?.type)!)
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(itemImage)
        view.addSubview(itemName)
        view.addSubview(formContainer)
        
        
        let titleConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 86),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let itemImageConstraints = [
            itemImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 52),
            itemImage.heightAnchor.constraint(equalToConstant: 75),
            itemImage.widthAnchor.constraint(equalToConstant: 75)
        ]
        
        let itemNameConstraints = [
            itemName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            itemName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            itemName.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 8),
            itemName.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let formConstraints = [
            formContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            formContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            formContainer.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 24),
            formContainer.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(itemImageConstraints)
        NSLayoutConstraint.activate(itemNameConstraints)
        NSLayoutConstraint.activate(formConstraints)
        
    }
    
    func formSetup() {
        formContainer.addSubview(shopContainer)
        shopContainer.addSubview(coffeeShopIcon)
        shopContainer.addSubview(coffeeShopLabel)
        
        
        let shopContainerConstraints = [
            shopContainer.topAnchor.constraint(equalTo: formContainer.topAnchor),
            shopContainer.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            shopContainer.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            shopContainer.heightAnchor.constraint(equalToConstant: 25)
        ]
        
        let coffeeShopNameConstraints = [
            coffeeShopLabel.leadingAnchor.constraint(equalTo: shopContainer.leadingAnchor, constant: 40),
            coffeeShopLabel.trailingAnchor.constraint(equalTo: shopContainer.trailingAnchor),
            coffeeShopLabel.topAnchor.constraint(equalTo: shopContainer.topAnchor),
            coffeeShopLabel.bottomAnchor.constraint(equalTo: shopContainer.bottomAnchor)
        ]
        
        let coffeeShopIconConstraints = [
            coffeeShopIcon.leadingAnchor.constraint(equalTo: shopContainer.leadingAnchor, constant: 4),
            coffeeShopIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 12),
            coffeeShopIcon.topAnchor.constraint(equalTo: shopContainer.topAnchor),
            coffeeShopIcon.bottomAnchor.constraint(equalTo: shopContainer.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(shopContainerConstraints)
        NSLayoutConstraint.activate(coffeeShopIconConstraints)
        NSLayoutConstraint.activate(coffeeShopNameConstraints)
        
        formContainer.addSubview(caffeineContainer)
        caffeineContainer.addSubview(coffeeIcon)
        caffeineContainer.addSubview(caffeineAmount)
        
        let caffeineConstraints = [
            caffeineContainer.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            caffeineContainer.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            caffeineContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 25),
            caffeineContainer.topAnchor.constraint(equalTo: shopContainer.bottomAnchor, constant: 28)
        ]
        
        let coffeeIconConstraints = [
            coffeeIcon.leadingAnchor.constraint(equalTo: caffeineContainer.leadingAnchor),
            coffeeIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 20),
            coffeeIcon.topAnchor.constraint(equalTo: caffeineContainer.topAnchor),
            coffeeIcon.bottomAnchor.constraint(equalTo: caffeineContainer.bottomAnchor)
        ]
        
        let caffeineAmountConstraints = [
            caffeineAmount.leadingAnchor.constraint(equalTo: shopContainer.leadingAnchor, constant: 40),
            caffeineAmount.trailingAnchor.constraint(equalTo: caffeineContainer.trailingAnchor),
            caffeineAmount.topAnchor.constraint(equalTo: caffeineContainer.topAnchor),
            caffeineAmount.bottomAnchor.constraint(equalTo: caffeineContainer.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(caffeineConstraints)
        NSLayoutConstraint.activate(coffeeIconConstraints)
        NSLayoutConstraint.activate(caffeineAmountConstraints)
        
        formContainer.addSubview(captionContainer)
        captionContainer.addSubview(captionIcon)
        captionContainer.addSubview(captionTitle)
        
        let captionConstraints = [
            captionContainer.leadingAnchor.constraint(equalTo: formContainer.leadingAnchor),
            captionContainer.trailingAnchor.constraint(equalTo: formContainer.trailingAnchor),
            captionContainer.topAnchor.constraint(equalTo: caffeineContainer.bottomAnchor, constant: 6),
            captionContainer.bottomAnchor.constraint(equalTo: formContainer.bottomAnchor)
        ]
        
        let captionIconConstraints = [
            captionIcon.leadingAnchor.constraint(equalTo: captionContainer.leadingAnchor, constant: 3),
            captionIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 20),
            captionIcon.topAnchor.constraint(equalTo: captionContainer.topAnchor, constant: 30),
            captionIcon.heightAnchor.constraint(lessThanOrEqualToConstant: 20)
        ]
        
        let captionTitleConstraints = [
            captionTitle.leadingAnchor.constraint(equalTo: captionContainer.leadingAnchor, constant: 40),
            captionTitle.trailingAnchor.constraint(equalTo: captionContainer.trailingAnchor),
            captionTitle.topAnchor.constraint(equalTo: captionContainer.topAnchor),
            captionTitle.bottomAnchor.constraint(equalTo: captionContainer.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(captionConstraints)
        NSLayoutConstraint.activate(captionIconConstraints)
        NSLayoutConstraint.activate(captionTitleConstraints)
        
        captionTitle.addSubview(inputField)
        
        let fieldConstraints = [
            inputField.leadingAnchor.constraint(equalTo: captionTitle.leadingAnchor),
            inputField.trailingAnchor.constraint(equalTo: captionTitle.trailingAnchor),
            inputField.topAnchor.constraint(equalTo: captionTitle.topAnchor, constant: 0),
            inputField.bottomAnchor.constraint(equalTo: captionTitle.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(fieldConstraints)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if let text = textField.text {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                if (text.count == 0) {
                    floatingLabelTextField.title = "Caption (\(text.count)/60)"
                    floatingLabelTextField.errorMessage = ""
                    button.isEnabled = false
                } else if(text.count <= 60) {
                    floatingLabelTextField.title = "Caption (\(text.count)/60)"
                    floatingLabelTextField.errorMessage = ""
                    button.isEnabled = true
                } else {
                    // The error message will only disappear when we reset it to nil or empty string
                    floatingLabelTextField.errorMessage = "Max Characters is 60."
                    button.isEnabled = false
                }
            }
        }
    }
}
