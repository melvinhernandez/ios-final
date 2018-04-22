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
    var address: String?
    var phone: String?
    var hours: [String]
    
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
            self.address = place.formattedAddress
            self.phone = place.phoneNumber
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
    static let coffeeShopMenus = [
        "ChIJ60w1qN9-hYARtzxtM7Qwdw4": [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 128, size: "large", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Caramel Latte", caffeine: 140, size: "large", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 140, size: "large", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 210, size: "extra-large", isHot: true),
                                        MenuItem(name: "Au Lait", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Au Lait", caffeine: 140, size: "large", isHot: true),
                                        MenuItem(name: "Chai Latte", caffeine: 70, size: "small", isHot: true),
                                        MenuItem(name: "Chai Latte", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Dirty Chai", caffeine: 160, size: "large", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true),
                                        MenuItem(name: "White Mocha", caffeine: 90, size: "small", isHot: true),
                                        MenuItem(name: "White Mocha", caffeine: 170, size: "large", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "large", isHot: true),
                                        MenuItem(name: "The Spider", caffeine: 160, size: "small", isHot: true),
                                        MenuItem(name: "The Spider", caffeine: 180, size: "large", isHot: true),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 26, size: "small", isHot: true),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 52, size: "small", isHot: true)
                                        ],
        "ChIJJe5a5i98hYARKF0NeaK-9kM": [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 128, size: "large", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Caffe Au Laut", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Caffe Latte", caffeine: 140, size: "large", isHot: true),
                                        MenuItem(name: "Caffe Latte", caffeine: 210, size: "extra-large", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true),
                                        MenuItem(name: "Blanca Mocha", caffeine: 90, size: "small", isHot: true),
                                        MenuItem(name: "Blanca Mocha", caffeine: 170, size: "large", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "large", isHot: true),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 26, size: "small", isHot: true),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 52, size: "small", isHot: true)
                                        ],
        "ChIJS4sDZp5-hYARIW-0A3ZOoqM": [
                                        MenuItem(name: "Hayes Valley", caffeine: 91, size: "medium", isHot: true),
                                        MenuItem(name: "Single Origin", caffeine: 80, size: "medium", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "medium", isHot: true),
                                        MenuItem(name: "Macchiato", caffeine: 128, size: "medium", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "medium", isHot: true),
                                        MenuItem(name: "Caffe Latte", caffeine: 90, size: "medium", isHot: true),
                                        MenuItem(name: "Caffe Mocha", caffeine: 85, size: "medium", isHot: true),
                                        MenuItem(name: "Almond Milk", caffeine: 70, size: "medium", isHot: true),
                                        MenuItem(name: "New Orleans", caffeine: 150, size: "medium", isHot: false),
                                        MenuItem(name: "Three Africas", caffeine: 150, size: "medium", isHot: false),
                                        MenuItem(name: "Ethiopa", caffeine: 70, size: "medium", isHot: true),
                                        MenuItem(name: "El Salvador", caffeine: 75, size: "medium", isHot: true),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 40, size: "medium", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "medium", isHot: true),
                                        ],
        "ChIJRzpkY55-hYARqFXlH-j8hSg" : [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true),
                                        MenuItem(name: "House Coffee", caffeine: 145, size: "medium", isHot: true),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true),
                                        MenuItem(name: "Cafe Au Lait", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Cafe Au Lait", caffeine: 106, size: "medium", isHot: true),
                                        MenuItem(name: "Cafe Au Lait", caffeine: 140, size: "large", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 70, size: "small", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 140, size: "medium", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 210, size: "large", isHot: true),
                                        MenuItem(name: "Breve Latte", caffeine: 70, size: "small", isHot: true),
                                        MenuItem(name: "Breve Latte", caffeine: 140, size: "medium", isHot: true),
                                        MenuItem(name: "Breve Latte", caffeine: 210, size: "large", isHot: true),
                                        MenuItem(name: "Vanilla Latte", caffeine: 70, size: "small", isHot: true),
                                        MenuItem(name: "Vanilla Latte", caffeine: 140, size: "medium", isHot: true),
                                        MenuItem(name: "Vanilla Latte", caffeine: 210, size: "large", isHot: true),
                                        MenuItem(name: "Dark or White Mocha", caffeine: 85, size: "small", isHot: true),
                                        MenuItem(name: "Dark or White Mocha", caffeine: 125, size: "medium", isHot: true),
                                        MenuItem(name: "Dark or White Mocha", caffeine: 165, size: "large", isHot: true),
                                        MenuItem(name: "Caramel Mocha", caffeine: 85, size: "small", isHot: true),
                                        MenuItem(name: "Caramel Mocha", caffeine: 125, size: "medium", isHot: true),
                                        MenuItem(name: "Caranel Mocha", caffeine: 165, size: "large", isHot: true),
                                        MenuItem(name: "Mexican Mocha", caffeine: 85, size: "small", isHot: true),
                                        MenuItem(name: "Mexican Mocha", caffeine: 125, size: "medium", isHot: true),
                                        MenuItem(name: "Mexican Mocha", caffeine: 165, size: "large", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 124, size: "medium", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Wake Up Call", caffeine: 80, size: "small", isHot: true),
                                        MenuItem(name: "Wake Up Call", caffeine: 160, size: "medium", isHot: true),
                                        MenuItem(name: "Wake Up Call", caffeine: 220, size: "large", isHot: true),
                                        MenuItem(name: "Rocket Fuel", caffeine: 90, size: "small", isHot: true),
                                        MenuItem(name: "Rocket Fuel", caffeine: 170, size: "medium", isHot: true),
                                        MenuItem(name: "Rocket Fuel", caffeine: 230, size: "large", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "medium", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 18, size: "large", isHot: true),
                                        MenuItem(name: "Mexican Hot Chocolate", caffeine: 5, size: "small", isHot: true),
                                        MenuItem(name: "Mexican Hot Chocolate", caffeine: 12, size: "medium", isHot: true),
                                        MenuItem(name: "Mexican Hot Chocolate", caffeine: 18, size: "large", isHot: true),
                                        MenuItem(name: "Americano", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Americano", caffeine: 64, size: "medium", isHot: true),
                                        MenuItem(name: "Americano", caffeine: 128, size: "large", isHot: true),
                                        MenuItem(name: "Chai Mocha", caffeine: 70, size: "small", isHot: true),
                                        MenuItem(name: "Chai Mocha", caffeine: 124, size: "medium", isHot: true),
                                        MenuItem(name: "Chai Mocha", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Dirty Chai", caffeine: 80, size: "small", isHot: true),
                                        MenuItem(name: "Dirty Chai", caffeine: 120, size: "medium", isHot: true),
                                        MenuItem(name: "Dirty Chai", caffeine: 160, size: "large", isHot: true),
                                        MenuItem(name: "Pot of tea", caffeine: 60, size: "large", isHot: true),
                                        MenuItem(name: "Tea Bag in a Cup", caffeine: 26, size: "small", isHot: true),
                                        MenuItem(name: "Tea Bag in a Cup", caffeine: 43, size: "medium", isHot: true),
                                        MenuItem(name: "Tea Bag in a Cup", caffeine: 52, size: "small", isHot: true)
                                    ],
        "ChIJbbVx8Sd8hYARG-HGSJWzlRw": [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 128, size: "large", isHot: true),
                                        MenuItem(name: "Americano", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Americano", caffeine: 128, size: "large", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Caramel Latte", caffeine: 140, size: "large", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 140, size: "large", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 210, size: "extra-large", isHot: true),
                                        MenuItem(name: "Macchiato", caffeine: 128, size: "small", isHot: true),
                                        MenuItem(name: "Macchiato", caffeine: 128, size: "large", isHot: true),
                                        MenuItem(name: "Au Lait", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Au Lait", caffeine: 140, size: "large", isHot: true),
                                        MenuItem(name: "Chai", caffeine: 70, size: "small", isHot: true),
                                        MenuItem(name: "Chai", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Chocolate Chai", caffeine: 80, size: "large", isHot: true),
                                        MenuItem(name: "Chocolate Chai", caffeine: 160, size: "large", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true),
                                        MenuItem(name: "Blended Mocha", caffeine: 165, size: "large", isHot: false),
                                        MenuItem(name: "Pot of tea", caffeine: 60, size: "large", isHot: true),
                                        MenuItem(name: "White Mocha", caffeine: 90, size: "small", isHot: true),
                                        MenuItem(name: "White Mocha", caffeine: 170, size: "large", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "large", isHot: true),
                                        MenuItem(name: "Hammer Head", caffeine: 160, size: "small", isHot: true),
                                        MenuItem(name: "Hammer Head", caffeine: 180, size: "large", isHot: true),
                                        MenuItem(name: "The Floor Coffee", caffeine: 190, size: "large", isHot: true),
                                    ],
        "ChIJiWTUXC98hYARrmlNLX89GbI": [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true),
                                        MenuItem(name: "House Coffee", caffeine: 145, size: "medium", isHot: true),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true),
                                        MenuItem(name: "Cafe Au Lait", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 140, size: "medium", isHot: true),
                                        MenuItem(name: "Latte", caffeine: 210, size: "large", isHot: true),
                                        MenuItem(name: "Mocha Blanca", caffeine: 85, size: "small", isHot: true),
                                        MenuItem(name: "Mocha Blanca", caffeine: 125, size: "medium", isHot: true),
                                        MenuItem(name: "Mocha Blanca", caffeine: 165, size: "large", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 125, size: "medium", isHot: true),
                                        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 124, size: "medium", isHot: true),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Caramella", caffeine: 80, size: "small", isHot: true),
                                        MenuItem(name: "Caramella", caffeine: 160, size: "medium", isHot: true),
                                        MenuItem(name: "Caramella", caffeine: 220, size: "large", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "medium", isHot: true),
                                        MenuItem(name: "Hot Chocolate", caffeine: 18, size: "large", isHot: true),
                                        MenuItem(name: "Americano", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Americano", caffeine: 64, size: "medium", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "medium", isHot: true),
                                        MenuItem(name: "Chai Latte", caffeine: 70, size: "small", isHot: true),
                                        MenuItem(name: "Chai Latte", caffeine: 124, size: "medium", isHot: true),
                                        MenuItem(name: "Chai Latte", caffeine: 154, size: "large", isHot: true),
                                        MenuItem(name: "Mocha Glacier", caffeine: 70, size:"medium", isHot: false),
                                        MenuItem(name: "Mocha Glacier", caffeine: 130, size:"large", isHot: false),
                                    ]
    ]
}

