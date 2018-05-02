//
//  PostsViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "postCell"
    var postsArray = [Post]()
    
    
    let logout: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "LOGOUT"
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed"
        
        collectionView?.backgroundColor = Colors.gray
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: cellId)
    }
    override func viewWillAppear(_ animated: Bool) {
        // Reload the tablebview.
//       postTableView.reloadData()
        // Update the data from Firebase
        retrieveData()
    }
    
    func retrieveData() {
        self.postsArray = []
        let dbRef = Database.database().reference()
        dbRef.child("Posts").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    print(posts)
                    for (_, val) in posts {
                        let post = val
                        let newPost = Post(username: post["username"]! as! String, item: post["menuItem"]! as! String, shop: post["coffeeShop"]! as! String, caffeine: post["caffeine"]! as! Int, caption: post["caption"]! as! String, dateString: post["date"]! as! String)
                        
                        self.postsArray.append(newPost)
                    }
                    self.postsArray = self.postsArray.sorted(by: {
                        $0.date.compare($1.date) == .orderedDescending
                    })
                    self.collectionView?.reloadData()
                }
            }
        })
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        let post = postsArray[indexPath.item]
        cell.nameLabel.text = post.username
        cell.coffeeShopLabel.text = post.shop
        cell.caffeineAmount.text = String(post.caffeine) + " mgs"
        cell.menuItemName.text = post.item
        cell.postCaption.text = post.caption
        cell.timeLabel.text = timeAgoFormat(post.date)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    func setupViews() {
//        logout.translatesAutoresizingMaskIntoConstraints = false
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
