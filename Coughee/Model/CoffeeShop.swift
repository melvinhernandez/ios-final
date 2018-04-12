//
//  CoffeeShop.swift
//
//
//  Created by Melvin  Hernandez on 4/6/18.
//

import Foundation
import GooglePlaces

class CoffeeShop {
    var placeID: String
    var name: String?
    var open: Bool?
    var image: UIImage?
    var lat: Double?
    var long: Double?
    
    init(placeID: String) {
        self.placeID = placeID
        fetchattr(placeID: placeID)
    }
    
    static let coffeeShopData = [
        CoffeeShop(placeID: "ChIJ60w1qN9-hYARtzxtM7Qwdw4"),
        CoffeeShop(placeID: "ChIJJe5a5i98hYARKF0NeaK-9kM"),
        CoffeeShop(placeID: "ChIJS4sDZp5-hYARIW-0A3ZOoqM"),
        CoffeeShop(placeID: "ChIJRzpkY55-hYARqFXlH-j8hSg"),
        CoffeeShop(placeID: "ChIJbbVx8Sd8hYARG-HGSJWzlRw"),
        CoffeeShop(placeID: "ChIJiWTUXC98hYARrmlNLX89GbI")
    ]
    
    func fetchattr(placeID: String) {
        let placesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeID)")
                return
            }
            
            self.name = place.name
            self.image = nil
            self.lat = place.coordinate.latitude
            self.long = place.coordinate.longitude
            let isOpen = place.openNowStatus
            switch isOpen {
                case .yes:
                    self.open = true
                case .no:
                    self.open = false
                case .unknown:
                    self.open = false
            }
        })
    }
}

