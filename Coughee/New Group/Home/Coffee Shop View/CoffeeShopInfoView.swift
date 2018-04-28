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
    
    let cellId = "infoItem"
    let mapId = "mapCell"
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(HoursCell.self, forCellReuseIdentifier: "hoursCell")
        NSLayoutConstraint.activate(tableConstraints)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.heightAnchor.constraint(equalToConstant: 40)
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            if let hours = coffeeShop?.hours.count {
                return hours
            }
            return 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Rating"
        case 2:
            return "Hours"
        case 3:
            return "Address"
        case 4:
            return "Website"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let header = UILabel()
        header.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        header.textAlignment = .center
        header.textColor = Colors.coral
        header.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(header)
        view.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        
        let headerCons = [
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let viewCons = [
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)

        ]
        NSLayoutConstraint.activate(viewCons)
        NSLayoutConstraint.activate(headerCons)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: mapId, for: indexPath) as! MapCell
            cell.coffeeShop = self.coffeeShop
            cell.setupCell()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            if let rating = coffeeShop?.rating {
                cell.textLabel?.text = "\(rating)"
            } else {
                cell.textLabel?.text = "Unknown"
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "hoursCell", for: indexPath) as! HoursCell
            if let hours = coffeeShop?.hours {
                cell.hourLabel.text = hours[indexPath.row]
            } else {
                cell.hourLabel.text = "Unknown"
            }
            cell.setupHours()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            if let addr = coffeeShop?.address {
                cell.textLabel?.text = addr
            } else {
                cell.textLabel?.text = "Unknown"
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            if let website = coffeeShop?.website {
                cell.textLabel?.text = website
            } else {
                cell.textLabel?.text = "Unknown"
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.textLabel?.text = "Hello"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250
        case 2:
            return 30
        default:
            return 40
        }
    }
    
}

class HoursCell: UITableViewCell {
    let hourLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupHours() {
        self.addSubview(hourLabel)
        let textLabelCons = [
            hourLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hourLabel.topAnchor.constraint(equalTo: self.topAnchor),
            hourLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            hourLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(textLabelCons)
    }
}

class MapCell: UITableViewCell {
    
    var coffeeShop: CoffeeShop?
    
    var mapContainer: GMSMapView = {
        let view = GMSMapView()
        return view
    }()

    
    func setupCell() {
        self.backgroundColor = Colors.gray
        setupMap()
    }
    
    func setupMap() {
        //setup mapView
        let camera = GMSCameraPosition.camera(withLatitude: coffeeShop!.lat!, longitude: coffeeShop!.long!, zoom: 18)
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        mapView.isMyLocationEnabled = true
        self.mapContainer = mapView
        self.addSubview(mapContainer)
        
        mapContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let cellViewConstraints = [
            mapContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapContainer.topAnchor.constraint(equalTo: self.topAnchor),
            mapContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cellViewConstraints)
        
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

