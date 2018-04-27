//
//  CoffeeShopInfoView.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/26/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class CoffeeShopInfoView: BaseCollectionCell, UITableViewDelegate, UITableViewDataSource {
    
    var coffeeShop: CoffeeShop?
    
    let cellId = "menuItem"
    let mapId = "mapCell"
    
    
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
        tableView.register(MapCell.self, forCellReuseIdentifier: mapId)
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: cellId)
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
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: mapId, for: indexPath) as! MapCell
            cell.coffeeShop = self.coffeeShop
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 250
        } else {
            return 70
        }
    }
    
}

class MapCell: UITableViewCell {
    
    var coffeeShop: CoffeeShop?
    
    var mapContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupCell() {
        self.backgroundColor = Colors.gray
        addSubview(mapContainer)
        setupMap()
        
        let cellViewConstraints = [
            mapContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapContainer.topAnchor.constraint(equalTo: self.topAnchor),
            mapContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cellViewConstraints)
    }
    
    func setupMap() {
        //setup mapView
        let camera = GMSCameraPosition.camera(withLatitude: coffeeShop!.lat!, longitude: coffeeShop!.long!, zoom: 18)
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        mapView.isMyLocationEnabled = true
        mapContainer = mapView
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(coffeeShop!.lat!, coffeeShop!.long!)
        marker.title = coffeeShop!.name
        marker.snippet = "Berkeley"
        marker.map = mapView
    }
}

class InfoCell: UITableViewCell {
    
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

