//
//  CoffeeShopView.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/11/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import GoogleMaps

class CoffeeShopViewController: UIViewController {
    
    var coffeeShop:CoffeeShop?
    
    var mapContainer:GMSMapView = {
        let container = GMSMapView()
        return container
    }()
    
    let bottomContainer: CoffeeShopContent = {
        let container = CoffeeShopContent()
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let shop = self.coffeeShop {
            navigationItem.title = shop.name
        }
        setupMap()
        setupContent()
        
        // TODO: If you want to offset the content to take into account the menu bar
        //          then watch: https://youtu.be/rRhJGnSmEKQ?list=PL0dzCUj1L5JGKdVUtA5xds1zcyzsz7HLj&t=1096
        
    }
    
    func setupMap() {
        //setup mapView
        let camera = GMSCameraPosition.camera(withLatitude: coffeeShop!.lat!, longitude: coffeeShop!.long!, zoom: 18)
        let mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        mapView.isMyLocationEnabled = true
        mapContainer = mapView
        self.view.addSubview(mapContainer)
        mapContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapContainer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mapContainer.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            mapContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapContainer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
            ])
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(coffeeShop!.lat!, coffeeShop!.long!)
        marker.title = coffeeShop!.name
        marker.snippet = "Berkeley"
        marker.map = mapView
    }
    
    func setupContent() {
        self.view.addSubview(bottomContainer)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomContainer.topAnchor.constraint(equalTo: mapContainer.bottomAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])

    }

}
