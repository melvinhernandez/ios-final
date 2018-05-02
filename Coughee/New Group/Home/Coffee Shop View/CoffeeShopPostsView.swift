//
//  CoffeeShopPostsView.swift
//  Coughee
//
//  Created by Melvin Hernandez and Juan Cervantes on 5/1/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class CoffeeShopPostsView: BaseCollectionCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "postCell"
    var shopsPostsArray = [Post]()
    var referenceKeys = [String]()
    var coffeeShop: CoffeeShop?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.gray
        cv.alwaysBounceVertical = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // Refresh UI element
    let refresher: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.tintColor = Colors.coral
        return ref
    }()

    
    // There exists no viewwillappear so you will have to call on setupView from coffee shop content.
    func setupCell() {
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        retrieveData()
        self.setupViews()
    }
    
    override func setupViews() {
        super.setupViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        
        self.refresher.addTarget(self, action: #selector(retrieveData), for: .valueChanged)
        collectionView.addSubview(refresher)
        
        let cvCons = [
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 75),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(cvCons)
    }
    
    //Retrieve Posts for corresponding coffee shop in DataBase
    @objc func retrieveData() {
        self.shopsPostsArray = []
        self.referenceKeys = []
        let dbRef = Database.database().reference()
        dbRef.child("Shops").child((coffeeShop?.placeID)!).observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let references = snapshot.value as? [String:NSDictionary] {
                    for (_, val) in references {
                        let reference = val
                        for (_, value) in reference {
                            self.referenceKeys.append((value as? String)!)
                        }
                    }
                }
            }
        })
        dbRef.child("Posts").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    print(posts)
                    for key in posts.keys {
                        if self.referenceKeys.contains(key) {
                            let post = posts[key] as! [String:AnyObject]
                            let newPost = Post(username: post["username"]! as! String, item: post["menuItem"]! as! String, shop: post["coffeeShop"]! as! String, caffeine: post["caffeine"]! as! Int, caption: post["caption"]! as! String, dateString: post["date"]! as! String)
                            self.shopsPostsArray.append(newPost)
                        }
                    }
                    print(self.shopsPostsArray)
                    self.shopsPostsArray = self.shopsPostsArray.sorted(by: {
                        $0.date.compare($1.date) == .orderedDescending
                    })
                    self.collectionView.reloadData()
                }
            }
        })
        self.stopRefresher()
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shopsPostsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        // change this once you have the data

        let post = self.shopsPostsArray[indexPath.item]
        cell.nameLabel.text = post.username
        cell.coffeeShopLabel.text = post.shop
        cell.caffeineAmount.text = String(post.caffeine) + " mgs"
        cell.menuItemName.text = post.item
        cell.postCaption.text = post.caption
        cell.timeLabel.text = timeAgoFormat(post.date)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 160)
    }
    
    //  Source: https://github.com/zemirco/swift-timeago
    func timeAgoFormat(_ date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }
        if let year = components.year, year >= 1 {
            return "One year ago"
        }
        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }
        if let month = components.month, month >= 1 {
            return "One month ago"
        }
        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }
        if let week = components.weekOfYear, week >= 1 {
            return "One week ago"
        }
        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }
        if let day = components.day, day >= 1 {
            return "Yesterday"
        }
        if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        }
        if let hour = components.hour, hour >= 1 {
            return "An hour ago"
        }
        if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        }
        if let minute = components.minute, minute >= 1 {
            return "A minute ago"
        }
        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }
        return "Just now"
    }
}
