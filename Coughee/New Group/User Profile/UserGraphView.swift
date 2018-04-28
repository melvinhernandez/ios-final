//
//  UserMenuView.swift
//  Coughee
//
//  Created by Ruben Escolero on 4/27/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation
//
//  CoffeeShopMenuView.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/22/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
//import Charts

protocol UserNewPostDelegate {
    func showNewPostModal(menuItem: MenuItem)
}

class UserMenuView: BaseCollectionCell, UITableViewDelegate, UITableViewDataSource {
    
    var menu : [MenuItem] = []
    
    var delegate: UserNewPostDelegate!
    
    let cellId = "usermenuItem"
    
    let sizes = [
        "extra-large": "XL",
        "large" : "L",
        "medium" : "M",
        "small" : "S"
    ]
    
    
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
        tableView.register(UserMenuItemCell.self, forCellReuseIdentifier: cellId)
        NSLayoutConstraint.activate(tableConstraints)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserMenuItemCell
        let menuItem = self.menu[indexPath.row]
        cell.itemName.text = "\(menuItem.name) (\(self.sizes[menuItem.size]!))"
        cell.itemImage.image = UIImage(named: menuItem.type)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = self.menu[indexPath.row]
        if (delegate == nil) {
            print("wtffff")
        }
        delegate.showNewPostModal(menuItem: menuItem)
    }
    
}

class UserMenuItemCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        label.text = "Mocha Glacier"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemImage: UIImageView = {
        let container = UIImageView()
        container.image = UIImage(named: "mocha")
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
        cellView.addSubview(itemName)
        
        let cellViewConstraints = [
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ]
        
        let imageConstraints = [
            itemImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            itemImage.widthAnchor.constraint(lessThanOrEqualToConstant: 28),
            itemImage.heightAnchor.constraint(lessThanOrEqualToConstant: 28),
            itemImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
        ]
        
        let itemNameConstraints = [
            itemName.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 12),
            itemName.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            itemName.topAnchor.constraint(equalTo: cellView.topAnchor),
            itemName.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cellViewConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(itemNameConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
