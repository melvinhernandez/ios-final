//
//  CoffeeShopView.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/11/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class CoffeeShopViewController: UIViewController {
    
    var coffeeShop:CoffeeShop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        if let shop = self.coffeeShop {
            navigationItem.title = shop.name
        }
    }
}
