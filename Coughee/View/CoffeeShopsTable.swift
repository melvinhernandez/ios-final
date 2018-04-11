//
//  CoffeeShopsTable.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class CoffeeShopsTable: UITableViewController {
    
    let coffeeShops = CoffeeShop.coffeeShopData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Coffee Shops"
        tableView.register(CoffeeShopCell.self, forCellReuseIdentifier: "coffeeShopCell")
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coffeeShop = coffeeShops[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeShopCell", for: indexPath) as! CoffeeShopCell
        cell.backgroundImageView.image = indexPath.row % 2 == 0 ? UIImage(named: "fsm") : UIImage(named: "milano")
        cell.titleText.text = coffeeShop.name
        cell.descriptionText.text = coffeeShop.open ? "Open" : "Closed"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coffeeShopController = CoffeeShopViewController()
        coffeeShopController.coffeeShop = coffeeShops[indexPath.row]
        navigationController?.pushViewController(coffeeShopController, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        segue.destination
//    }

}
