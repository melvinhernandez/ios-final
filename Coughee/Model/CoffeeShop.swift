//
//  CoffeeShop.swift
//
//
//  Created by Melvin  Hernandez on 4/6/18.
//

import Foundation

class CoffeeShop {
    
    var name: String
    var open: Bool
    
    init(name: String, open: Bool) {
        self.name = name
        self.open = open
    }
    
    static let coffeeShopData = [
        CoffeeShop(name: "Free Speech", open: true),
        CoffeeShop(name: "Caffe Strada", open: true),
        CoffeeShop(name: "Blue Bottle Coffee", open: true),
        CoffeeShop(name: "People's Cafe", open: true),
        CoffeeShop(name: "Cafe Blue Door", open: false),
        CoffeeShop(name: "Cafe Milano", open: true)
    ]
}

