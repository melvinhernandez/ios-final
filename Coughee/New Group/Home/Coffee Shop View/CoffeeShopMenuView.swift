//
//  CoffeeShopMenuView.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/22/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class CoffeeShopMenuView: BaseCollectionCell, UITableViewDelegate, UITableViewDataSource {
    
    var menu : [MenuItem] = []
    
    let cellId = "menuItem"
    
    let sizes = [
        "extra-large": "XL",
        "large" : "L",
        "medium" : "M",
        "small" : "S"
    ]
    
    
    let tableView: UITableView = {
        print("hello table view")
        let tv = UITableView()
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
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: cellId)
        NSLayoutConstraint.activate(tableConstraints)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("COUNTTTT:::::::: \(menu.count)")
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuItemCell
        let menuItem = self.menu[indexPath.row]
        cell.itemName.text = "\(menuItem.name) (\(self.sizes[menuItem.size]!))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = self.menu[indexPath.row]
        print(menuItem.name)
    }
    
}

class MenuItemCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        label.text = "Mocha Glacier"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    func setupCell() {
        addSubview(cellView)
        cellView.addSubview(itemName)
        
        let cellViewConstraints = [
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        let itemNameConstraints = [
            itemName.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            itemName.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            itemName.topAnchor.constraint(equalTo: cellView.topAnchor),
            itemName.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cellViewConstraints)
        NSLayoutConstraint.activate(itemNameConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
