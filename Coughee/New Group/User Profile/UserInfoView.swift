//
//  UserInfoView.swift
//  Coughee
//
//  Created by Ruben Escolero on 4/27/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//



import Foundation
import UIKit
import GoogleMaps

class UserInfoView: BaseCollectionCell, UITableViewDelegate, UITableViewDataSource {
    
    let currentUser = CurrentUser()
    
    let cellId = "userinfoItem"
    let avatarId = "useravatarCell"
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = Colors.gray
        tv.separatorStyle = .none
        tv.separatorInset = .zero
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        let tableConstraints = [
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70)
        ]
        tableView.register(UserAvatarCell.self, forCellReuseIdentifier: avatarId)
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: cellId)
        NSLayoutConstraint.activate(tableConstraints)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0 && indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: avatarId, for: indexPath) as! UserAvatarCell
            cell.itemImage.image = UIImage(named: "frank")
            cell.itemImage.layer.cornerRadius = 100
            cell.itemImage.clipsToBounds = true
            //cell.backgroundColor = .lightGray
            cell.cellView.backgroundColor = .lightGray
            //cell.itemImage.contentMode = .center

            return cell
        } else if (indexPath.section == 1){
            let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserInfoCell
            cell.userName.text = "Name:     " + currentUser.username
            //cell.userUsername.text = currentUser.username
            
            
            return cell
        } else if (indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserInfoCell
            cell.userName.text = "Email:     " + currentUser.dbRef.description()
            //cell.userUsername.text = currentUser.id
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.textLabel?.text = "Hello"
           
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 250
        } else {
            return 70
        }
    }
    
}

class UserAvatarCell: UITableViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemImage: UIImageView = {
        let container = UIImageView()
        container.image = UIImage(named: "mocha")
        container.layer.cornerRadius = 50
        container.contentMode = .scaleAspectFill
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    func setupCell() {
        self.backgroundColor = Colors.gray
        addSubview(cellView)
        cellView.addSubview(itemImage)
        
        let cellViewConstraints = [
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ]
        
        let imageConstraints = [
            itemImage.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            itemImage.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            itemImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            itemImage.centerXAnchor.constraint(equalTo: cellView.centerXAnchor)
            //itemImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            //itemImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 2)
        ]
        
        
        NSLayoutConstraint.activate(cellViewConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        //NSLayoutConstraint.activate(itemNameConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class UserInfoCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userUsername: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    func setupCell() {
        self.backgroundColor = Colors.gray
        addSubview(cellView)
        cellView.addSubview(userUsername)
        cellView.addSubview(userName)
        
        let cellViewConstraints = [
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ]
   
        
        let userNameConstraints = [
            userName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            userName.trailingAnchor.constraint(equalTo: userUsername.trailingAnchor, constant: 12),
            userName.topAnchor.constraint(equalTo: cellView.topAnchor),
            userName.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ]
        
        let userUsernameConstraints = [
            userUsername.leadingAnchor.constraint(equalTo: userName.trailingAnchor, constant: 12),
            userUsername.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 12),
            userUsername.topAnchor.constraint(equalTo: cellView.topAnchor),
            userUsername.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cellViewConstraints)
        NSLayoutConstraint.activate(userUsernameConstraints)
        NSLayoutConstraint.activate(userNameConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

