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
    var cachedShops = [String: CoffeeShop]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !CurrentUser.isLoggedIn() {
            self.dismiss(animated: true, completion: nil)
        }
        navigationItem.title = "Coffee Shops"
        tableView.register(CoffeeShopCell.self, forCellReuseIdentifier: "coffeeShopCell")
        tableView.separatorColor = .white
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coffeeShop = coffeeShops[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeShopCell", for: indexPath) as! CoffeeShopCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        if let cachedShop = cachedShops[coffeeShop.placeID] {
            cell.backgroundImageView.image = cachedShop.image
            cell.titleText.text = cachedShop.name
        } else {
            loadFirstPhotoForPlace(placeID: coffeeShop.placeID, shop: coffeeShop, cell: cell)
        }
        return cell
    }
    
    func fetchData() {
        for shop in self.coffeeShops {
            cacheShopPhoto(shop)
        }
    }
    
    func cacheShopPhoto(_ shop: CoffeeShop) -> Void {
        let placeID = shop.placeID
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.cacheImageForMeta(photoMetadata: firstPhoto, shop: shop)
                }
            }
        }
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
    
    func cacheImageForMeta(photoMetadata: GMSPlacePhotoMetadata, shop: CoffeeShop) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    shop.image = photo
                    self.cachedShops[shop.placeID] = shop
                }
            }
        })
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
                    self.cachedShops[shop.placeID] = shop
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

