//
//  CoffeeShopsTable.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import GooglePlaces

class CoffeeShopsTable: UITableViewController {
    
    let coffeeShops = CoffeeShop.coffeeShopData

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Coffee Shops"
        tableView.register(CoffeeShopCell.self, forCellReuseIdentifier: "coffeeShopCell")
        tableView.separatorColor = .white
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coffeeShop = coffeeShops[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeShopCell", for: indexPath) as! CoffeeShopCell
        loadFirstPhotoForPlace(placeID: coffeeShop.placeID, shop: coffeeShop, cell: cell)
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    func loadFirstPhotoForPlace(placeID: String, shop: CoffeeShop, cell: CoffeeShopCell) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto, shop: shop, cell: cell)
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata, shop: CoffeeShop, cell: CoffeeShopCell) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    shop.image = photo
                    cell.backgroundImageView.image = photo
                    cell.titleText.text = shop.name
                    if let open = shop.open {
                        cell.descriptionText.text = open ? "Open" : "Closed"
                    } else {
                        cell.descriptionText.text = "Loading..."
                    }
                }
            }
        })
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coffeeShopController = CoffeeShopViewController()
        coffeeShopController.coffeeShop = coffeeShops[indexPath.row]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(coffeeShopController, animated: true)
    }

}
