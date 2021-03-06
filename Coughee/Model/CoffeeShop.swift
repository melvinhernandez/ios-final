//
//  CoffeeShop.swift
//
//
//  Created by Juan Cervantes on 4/6/18.
//

import Foundation
import GooglePlaces
import FirebaseDatabase
import FirebaseAuth

class CoffeeShop {
    var placeID: String
    var name: String?
    var open: Bool?
    var image: UIImage?
    var lat: Double?
    var long: Double?
    var address: String?
    var phone: String?
    var hours: [String] = [String]()
    var rating: Double?
    var website: String?
    
    init(placeID: String) {
        self.placeID = placeID
        fetchattr(placeID: placeID)
        moreInfo(placeID: placeID)
    }
    
    static let coffeeShopData = [
        //NOT GENERIC MENUS
        CoffeeShop(placeID: "ChIJ60w1qN9-hYARtzxtM7Qwdw4"), //FSM
        CoffeeShop(placeID: "ChIJJe5a5i98hYARKF0NeaK-9kM"),
        CoffeeShop(placeID: "ChIJS4sDZp5-hYARIW-0A3ZOoqM"),
        CoffeeShop(placeID: "ChIJRzpkY55-hYARqFXlH-j8hSg"),
        CoffeeShop(placeID: "ChIJbbVx8Sd8hYARG-HGSJWzlRw"),
        CoffeeShop(placeID: "ChIJiWTUXC98hYARrmlNLX89GbI"),
        //GENERRIC MENUS
        CoffeeShop(placeID: "ChIJxRGX8p1-hYARBrkP22qWlKg"), //Starbucks
        CoffeeShop(placeID: "ChIJ0acevi58hYARWbsFtrpCPHI"), //Romeos Cafe
        CoffeeShop(placeID: "ChIJn-29E8V9hYARmAezYfXpKBo"), //Philz
        CoffeeShop(placeID: "ChIJS4KrsCh8hYARFrqy1pEUSeg"), //Sodol Coffee Tasting House
        CoffeeShop(placeID: "ChIJ--NzyyV8hYARe3Tq719Z_P0"), //Babette South Hall Coffee Bar
        CoffeeShop(placeID: "ChIJX9GbpDJ8hYARzIu23Ssq8cg"), //Sack's Coffee House
        CoffeeShop(placeID: "ChIJY2RivS58hYARUDQo9IrHJx0"), //Peets Coffee
        CoffeeShop(placeID: "ChIJg0TY5SR8hYARbxbNBfOi9SA"), //The Coffee Lab
        CoffeeShop(placeID: "ChIJvxp408F-hYAReY3LjPTySLI"), //Algorithm Coffee Co.
        CoffeeShop(placeID: "ChIJze0rc9R9hYARffVXzhCeOAU"), //Allegro Coffee Co.
        CoffeeShop(placeID: "ChIJ_x_MjyF8hYARwSGsrL7Qwic"), //Brewed Awakening
        CoffeeShop(placeID: "ChIJq0N1G5x-hYAROQV3bj4cTTk"), //K's Coffee Shop
        CoffeeShop(placeID: "ChIJL0EVdup-hYARU-kkP-9o98c"), //HighWire Coffee Roasters
        CoffeeShop(placeID: "ChIJJ5MtD59-hYARB9wKo5dZPwQ"), //Berkeley Espresso
        CoffeeShop(placeID: "ChIJW2yuxCh8hYARGGQHIaJzsZc"), //1951 Coffee Shop
        CoffeeShop(placeID: "ChIJdwOuqn5-hYARj0bLYaWu8Zk"), //Rasa Caffee
        CoffeeShop(placeID: "ChIJCeoIuHt-hYAR0OZUwj2Gqxk"), //Alchemy Collective Cafe and Roaster
        CoffeeShop(placeID: "ChIJG1xfM899hYARfrx1-OhOLQM"), //Souvenir Coffee
        CoffeeShop(placeID: "ChIJSTgrYYJ-hYARI-qF_8z6T4Y"), //Way Station Brew
        CoffeeShop(placeID: "ChIJc4U-eZ9-hYAR5ih4d-bZpBI"), //Victory Point Cafe
        CoffeeShop(placeID: "ChIJAQ29ep9-hYARjBvpiTPVXVM")  //Fertile Grounds

    ]
    func moreInfo(placeID: String) {
        let url_str = "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyC7G9bC4TpcM9O_L1_O7eFNnuti1Qu23iI&placeid=" + placeID
        let url = URL(string: url_str)
        let session = URLSession.shared
        let task = session.dataTask(with: url!,
                                    completionHandler: {
                                        (data, response, error) -> Void in
                                        if error == nil {
                                            let data: Data = data!
                                            let json = try? JSONSerialization.jsonObject(with:
                                                data, options: [])
                                            if let dictionary = json as? [String: Any] {
                                                if let result = dictionary["result"] as?  [String: Any] {
                                                    if let one_level = result["opening_hours"] as? [String: Any] {
                                                        if let hours = one_level["weekday_text"] as? [String] {
                                                            self.hours = hours
                                                        }
                                                    }
                                                    if let rating = result["rating"] as! Double? {
                                                        self.rating = rating                                                    }
                                                    if let website = result["website"] as! String? {
                                                        self.website = website
                                                    }
                                                }
                                            }
                                        }
        })
        
        task.resume()
    }
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
                case .no:
                    self.open = false
                default:
                    self.open = true
            }
        })
    }
    
    /*
     Add new post to coffe shop.
     */
    func addNewPost(postID: String) {
        // YOUR CODE HERE
        let dbRef = Database.database().reference()
        let ref = dbRef.child("Shops").child(self.placeID).child("Posts").childByAutoId()
        ref.setValue(postID)
    }
    
    static let genericMenu = [
        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true, type: "coffee"),
        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true, type: "coffee"),
        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true, type: "espresso"),
        MenuItem(name: "Espresso", caffeine: 128, size: "large", isHot: true, type: "espresso"),
        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true, type: "cappuccino"),
        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true, type: "cappuccino"),
        MenuItem(name: "Caramel Latte", caffeine: 140, size: "large", isHot: true, type: "latte"),
        MenuItem(name: "Latte", caffeine: 140, size: "large", isHot: true, type: "latte"),
        MenuItem(name: "Latte", caffeine: 210, size: "extra-large", isHot: true, type: "latte"),
        MenuItem(name: "Au Lait", caffeine: 64, size: "small", isHot: true, type: "latte"),
        MenuItem(name: "Au Lait", caffeine: 140, size: "large", isHot: true, type: "latte"),
        MenuItem(name: "Chai Latte", caffeine: 70, size: "small", isHot: true, type: "latte"),
        MenuItem(name: "Chai Latte", caffeine: 154, size: "large", isHot: true, type: "latte"),
        MenuItem(name: "Dirty Chai", caffeine: 160, size: "large", isHot: true, type: "latte"),
        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true, type: "mocha"),
        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true, type: "mocha"),
        MenuItem(name: "White Mocha", caffeine: 90, size: "small", isHot: true, type: "mocha"),
        MenuItem(name: "White Mocha", caffeine: 170, size: "large", isHot: true, type: "mocha"),
        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true, type: "hotchoco"),
        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "large", isHot: true, type: "hotchoco"),
        MenuItem(name: "Organic Hot Tea", caffeine: 26, size: "small", isHot: true, type: "tea"),
        MenuItem(name: "Organic Hot Tea", caffeine: 52, size: "small", isHot: true, type: "tea"),
        MenuItem(name: "Dirty Chai", caffeine: 80, size: "small", isHot: true, type: "specialty"),
        MenuItem(name: "Dirty Chai", caffeine: 120, size: "medium", isHot: true, type: "specialty"),
        MenuItem(name: "Dirty Chai", caffeine: 160, size: "large", isHot: true, type: "specialty")
    ]
    static let coffeeShopMenus = [
        "ChIJ60w1qN9-hYARtzxtM7Qwdw4": [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true, type: "coffee"),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true, type: "coffee"),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true, type: "espresso"),
                                        MenuItem(name: "Espresso", caffeine: 128, size: "large", isHot: true, type: "espresso"),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Caramel Latte", caffeine: 140, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 140, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 210, size: "extra-large", isHot: true, type: "latte"),
                                        MenuItem(name: "Au Lait", caffeine: 64, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Au Lait", caffeine: 140, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Chai Latte", caffeine: 70, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Chai Latte", caffeine: 154, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Dirty Chai", caffeine: 160, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "White Mocha", caffeine: 90, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "White Mocha", caffeine: 170, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "large", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "The Spider", caffeine: 160, size: "small", isHot: true, type: "specialty"),
                                        MenuItem(name: "The Spider", caffeine: 180, size: "large", isHot: true, type: "specialty"),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 26, size: "small", isHot: true, type: "tea"),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 52, size: "small", isHot: true, type: "tea")
                                        ],
        "ChIJJe5a5i98hYARKF0NeaK-9kM": [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true, type: "coffee"),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true, type: "coffee"),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true, type: "espresso"),
                                        MenuItem(name: "Espresso", caffeine: 128, size: "large", isHot: true, type: "espresso"),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Caffe Au Laut", caffeine: 64, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Caffe Latte", caffeine: 140, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Caffe Latte", caffeine: 210, size: "extra-large", isHot: true, type: "latte"),
                                        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Blanca Mocha", caffeine: 90, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Blanca Mocha", caffeine: 170, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "large", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 26, size: "small", isHot: true, type: "tea"),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 52, size: "small", isHot: true, type: "tea")
                                        ],
        "ChIJS4sDZp5-hYARIW-0A3ZOoqM": [
                                        MenuItem(name: "Hayes Valley", caffeine: 91, size: "medium", isHot: true, type: "espresso"),
                                        MenuItem(name: "Single Origin", caffeine: 80, size: "medium", isHot: true, type: "specialty"),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "medium", isHot: true, type: "espresso"),
                                        MenuItem(name: "Macchiato", caffeine: 128, size: "medium", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "medium", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Caffe Latte", caffeine: 90, size: "medium", isHot: true, type: "latte"),
                                        MenuItem(name: "Caffe Mocha", caffeine: 85, size: "medium", isHot: true, type: "mocha"),
                                        MenuItem(name: "Almond Milk", caffeine: 70, size: "medium", isHot: true, type: "mocha"),
                                        MenuItem(name: "New Orleans", caffeine: 150, size: "medium", isHot: false, type: "specialty"),
                                        MenuItem(name: "Three Africas", caffeine: 150, size: "medium", isHot: false, type: "specialty"),
                                        MenuItem(name: "Ethiopa", caffeine: 70, size: "medium", isHot: true, type: "specialty"),
                                        MenuItem(name: "El Salvador", caffeine: 75, size: "medium", isHot: true, type: "specialty"),
                                        MenuItem(name: "Organic Hot Tea", caffeine: 40, size: "medium", isHot: true, type: "tea"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "medium", isHot: true, type: "hotchoco"),
                                        ],
        "ChIJRzpkY55-hYARqFXlH-j8hSg" : [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true, type: "coffee"),
                                        MenuItem(name: "House Coffee", caffeine: 145, size: "medium", isHot: true, type: "coffee"),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true, type: "coffee"),
                                        MenuItem(name: "Cafe Au Lait", caffeine: 64, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Cafe Au Lait", caffeine: 106, size: "medium", isHot: true, type: "latte"),
                                        MenuItem(name: "Cafe Au Lait", caffeine: 140, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 70, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 140, size: "medium", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 210, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Breve Latte", caffeine: 70, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Breve Latte", caffeine: 140, size: "medium", isHot: true, type: "latte"),
                                        MenuItem(name: "Breve Latte", caffeine: 210, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Vanilla Latte", caffeine: 70, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Vanilla Latte", caffeine: 140, size: "medium", isHot: true, type: "latte"),
                                        MenuItem(name: "Vanilla Latte", caffeine: 210, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Dark or White Mocha", caffeine: 85, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Dark or White Mocha", caffeine: 125, size: "medium", isHot: true, type: "mocha"),
                                        MenuItem(name: "Dark or White Mocha", caffeine: 165, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Caramel Mocha", caffeine: 85, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Caramel Mocha", caffeine: 125, size: "medium", isHot: true, type: "mocha"),
                                        MenuItem(name: "Caranel Mocha", caffeine: 165, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mexican Mocha", caffeine: 85, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mexican Mocha", caffeine: 125, size: "medium", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mexican Mocha", caffeine: 165, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Cappuccino", caffeine: 124, size: "medium", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Wake Up Call", caffeine: 80, size: "small", isHot: true, type: "specialty"),
                                        MenuItem(name: "Wake Up Call", caffeine: 160, size: "medium", isHot: true, type: "specialty"),
                                        MenuItem(name: "Wake Up Call", caffeine: 220, size: "large", isHot: true, type: "specialty"),
                                        MenuItem(name: "Rocket Fuel", caffeine: 90, size: "small", isHot: true, type: "specialty"),
                                        MenuItem(name: "Rocket Fuel", caffeine: 170, size: "medium", isHot: true, type: "specialty"),
                                        MenuItem(name: "Rocket Fuel", caffeine: 230, size: "large", isHot: true, type: "specialty"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "medium", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 18, size: "large", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Mexican Hot Chocolate", caffeine: 5, size: "small", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Mexican Hot Chocolate", caffeine: 12, size: "medium", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Mexican Hot Chocolate", caffeine: 18, size: "large", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Americano", caffeine: 64, size: "small", isHot: true, type: "espresso"),
                                        MenuItem(name: "Americano", caffeine: 64, size: "medium", isHot: true, type: "espresso"),
                                        MenuItem(name: "Americano", caffeine: 128, size: "large", isHot: true, type: "espresso"),
                                        MenuItem(name: "Chai Mocha", caffeine: 70, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Chai Mocha", caffeine: 124, size: "medium", isHot: true, type: "mocha"),
                                        MenuItem(name: "Chai Mocha", caffeine: 154, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Dirty Chai", caffeine: 80, size: "small", isHot: true, type: "specialty"),
                                        MenuItem(name: "Dirty Chai", caffeine: 120, size: "medium", isHot: true, type: "specialty"),
                                        MenuItem(name: "Dirty Chai", caffeine: 160, size: "large", isHot: true, type: "specialty"),
                                        MenuItem(name: "Pot of tea", caffeine: 60, size: "large", isHot: true, type: "tea"),
                                        MenuItem(name: "Tea Bag in a Cup", caffeine: 26, size: "small", isHot: true, type: "tea"),
                                        MenuItem(name: "Tea Bag in a Cup", caffeine: 43, size: "medium", isHot: true, type: "tea"),
                                        MenuItem(name: "Tea Bag in a Cup", caffeine: 52, size: "small", isHot: true, type: "tea")
                                    ],
        "ChIJbbVx8Sd8hYARG-HGSJWzlRw": [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true, type: "coffee"),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true, type: "coffee"),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true, type: "espresso"),
                                        MenuItem(name: "Espresso", caffeine: 128, size: "large", isHot: true, type: "espresso"),
                                        MenuItem(name: "Americano", caffeine: 64, size: "small", isHot: true, type: "espresso"),
                                        MenuItem(name: "Americano", caffeine: 128, size: "large", isHot: true, type: "espresso"),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Caramel Latte", caffeine: 140, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 140, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 210, size: "extra-large", isHot: true, type: "latte"),
                                        MenuItem(name: "Macchiato", caffeine: 128, size: "small", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Macchiato", caffeine: 128, size: "large", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Au Lait", caffeine: 64, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Au Lait", caffeine: 140, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Chai", caffeine: 70, size: "small", isHot: true, type: "specialty"),
                                        MenuItem(name: "Chai", caffeine: 154, size: "large", isHot: true, type: "specialty"),
                                        MenuItem(name: "Chocolate Chai", caffeine: 80, size: "large", isHot: true, type: "specialty"),
                                        MenuItem(name: "Chocolate Chai", caffeine: 160, size: "large", isHot: true, type: "specialty"),
                                        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Blended Mocha", caffeine: 165, size: "large", isHot: false, type: "colddrink"),
                                        MenuItem(name: "Pot of tea", caffeine: 60, size: "large", isHot: true, type: "tea"),
                                        MenuItem(name: "White Mocha", caffeine: 90, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "White Mocha", caffeine: 170, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "large", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Hammer Head", caffeine: 160, size: "small", isHot: true, type: "specialty"),
                                        MenuItem(name: "Hammer Head", caffeine: 180, size: "large", isHot: true, type: "specialty"),
                                        MenuItem(name: "The Floor Coffee", caffeine: 190, size: "large", isHot: true, type: "colddrink"),
                                    ],
        "ChIJiWTUXC98hYARrmlNLX89GbI": [
                                        MenuItem(name: "House Coffee", caffeine: 91, size: "small", isHot: true, type: "coffee"),
                                        MenuItem(name: "House Coffee", caffeine: 145, size: "medium", isHot: true, type: "coffee"),
                                        MenuItem(name: "House Coffee", caffeine: 190, size: "large", isHot: true, type: "coffee"),
                                        MenuItem(name: "Cafe Au Lait", caffeine: 64, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 140, size: "medium", isHot: true, type: "latte"),
                                        MenuItem(name: "Latte", caffeine: 210, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Mocha Blanca", caffeine: 85, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mocha Blanca", caffeine: 125, size: "medium", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mocha Blanca", caffeine: 165, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mocha", caffeine: 85, size: "small", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mocha", caffeine: 125, size: "medium", isHot: true, type: "mocha"),
                                        MenuItem(name: "Mocha", caffeine: 165, size: "large", isHot: true, type: "mocha"),
                                        MenuItem(name: "Cappuccino", caffeine: 77, size: "small", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Cappuccino", caffeine: 124, size: "medium", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Cappuccino", caffeine: 154, size: "large", isHot: true, type: "cappuccino"),
                                        MenuItem(name: "Caramella", caffeine: 80, size: "small", isHot: true, type: "colddrink"),
                                        MenuItem(name: "Caramella", caffeine: 160, size: "medium", isHot: true, type: "colddrink"),
                                        MenuItem(name: "Caramella", caffeine: 220, size: "large", isHot: true, type: "colddrink"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 5, size: "small", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 12, size: "medium", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Hot Chocolate", caffeine: 18, size: "large", isHot: true, type: "hotchoco"),
                                        MenuItem(name: "Americano", caffeine: 64, size: "small", isHot: true, type: "espresso"),
                                        MenuItem(name: "Americano", caffeine: 64, size: "medium", isHot: true, type: "espresso"),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "small", isHot: true, type: "espresso"),
                                        MenuItem(name: "Espresso", caffeine: 64, size: "medium", isHot: true, type: "espresso"),
                                        MenuItem(name: "Chai Latte", caffeine: 70, size: "small", isHot: true, type: "latte"),
                                        MenuItem(name: "Chai Latte", caffeine: 124, size: "medium", isHot: true, type: "latte"),
                                        MenuItem(name: "Chai Latte", caffeine: 154, size: "large", isHot: true, type: "latte"),
                                        MenuItem(name: "Mocha Glacier", caffeine: 70, size:"medium", isHot: false, type: "colddrink"),
                                        MenuItem(name: "Mocha Glacier", caffeine: 130, size:"large", isHot: false, type: "colddrink"),
                                    ],
        "ChIJxRGX8p1-hYARBrkP22qWlKg": genericMenu,
        "ChIJ0acevi58hYARWbsFtrpCPHI": genericMenu,
        "ChIJn-29E8V9hYARmAezYfXpKBo": genericMenu,
        "ChIJS4KrsCh8hYARFrqy1pEUSeg": genericMenu,
        "ChIJ--NzyyV8hYARe3Tq719Z_P0": genericMenu,
        "ChIJX9GbpDJ8hYARzIu23Ssq8cg": genericMenu,
        "ChIJY2RivS58hYARUDQo9IrHJx0": genericMenu,
        "ChIJg0TY5SR8hYARbxbNBfOi9SA": genericMenu,
        "ChIJvxp408F-hYAReY3LjPTySLI": genericMenu,
        "ChIJze0rc9R9hYARffVXzhCeOAU": genericMenu,
        "ChIJ_x_MjyF8hYARwSGsrL7Qwic": genericMenu,
        "ChIJq0N1G5x-hYAROQV3bj4cTTk": genericMenu,
        "ChIJL0EVdup-hYARU-kkP-9o98c": genericMenu,
        "ChIJJ5MtD59-hYARB9wKo5dZPwQ": genericMenu,
        "ChIJW2yuxCh8hYARGGQHIaJzsZc": genericMenu,
        "ChIJdwOuqn5-hYARj0bLYaWu8Zk": genericMenu,
        "ChIJCeoIuHt-hYAR0OZUwj2Gqxk": genericMenu,
        "ChIJG1xfM899hYARfrx1-OhOLQM": genericMenu,
        "ChIJSTgrYYJ-hYARI-qF_8z6T4Y": genericMenu,
        "ChIJc4U-eZ9-hYAR5ih4d-bZpBI": genericMenu,
        "ChIJAQ29ep9-hYARjBvpiTPVXVM": genericMenu
    ]

}

