//
//  UserViewController.swift
//  Coughee
//
//  Created by Juan Cervantes and Melvin  Hernandez on 4/18/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import GoogleMaps
import FontAwesome_swift
import FirebaseDatabase

class UserViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let postCellId = "postCell"
    private let meterCellId = "meterCell"
    
    private let currentUser = CurrentUser()
    
    var UserPostsArray = [Post]()
    var caffeineIntake = 0
    var userRefKeys = [String]()
    let dbRef = Database.database().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !CurrentUser.isLoggedIn() {
            self.dismiss(animated: true, completion: nil)
        }
        navigationItem.title = currentUser.username

        collectionView?.backgroundColor = Colors.gray
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: postCellId)
        collectionView?.register(MeterCell.self, forCellWithReuseIdentifier: meterCellId)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveData()
    }
    
    func retrieveData() {
        self.UserPostsArray = []
        self.userRefKeys = []
        self.caffeineIntake = 0
        dbRef.child("Users").child(currentUser.id).child("Posts").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let references = snapshot.value as? [String:AnyObject] {
                    for (_, val) in references {
                        self.userRefKeys.append((val as? String)!)
                    }
                    self.dbRef.child("Posts").observeSingleEvent(of: .value, with: { snapshot -> Void in
                        if snapshot.exists() {
                            if let posts = snapshot.value as? [String:AnyObject] {
                                for key in posts.keys {
                                    if self.userRefKeys.contains(key) {
                                        let post = posts[key] as! [String:AnyObject]
                                        let postDateAsString = post["date"]!
                                        let dateFormatterGet = DateFormatter()
                                        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                        let postDate: Date? = dateFormatterGet.date(from: postDateAsString as! String)
                                        if let diff = Calendar.current.dateComponents([.hour], from: postDate! as Date, to: Date()).hour, diff < 24 {
                                            self.caffeineIntake += post["caffeine"] as! Int
                                        }
                                        let newPost = Post(username: post["username"]! as! String, item: post["menuItem"]! as! String, shop: post["coffeeShop"]! as! String, caffeine: post["caffeine"]! as! Int, caption: post["caption"]! as! String, dateString: post["date"]! as! String, img: post["img"] as! String)
                                        self.UserPostsArray.append(newPost)
                                    }
                                }
                                self.UserPostsArray = self.UserPostsArray.sorted(by: {
                                    $0.date.compare($1.date) == .orderedDescending
                                })
                                self.collectionView?.reloadData()
                            }
                        }
                    })
                }
                
            }
        })
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.UserPostsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: meterCellId, for: indexPath) as! MeterCell
            cell.mgs = self.caffeineIntake
            cell.setupViews()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellId, for: indexPath) as! PostCell
            let post = self.UserPostsArray[indexPath.item]
            cell.nameLabel.text = post.username
            cell.coffeeShopLabel.text = post.shop
            cell.caffeineAmount.text = String(post.caffeine) + " mgs"
            cell.menuItemName.text = post.item
            cell.postCaption.text = post.caption
            cell.timeLabel.text = timeAgoFormat(post.date)
            cell.avatarView.image = UIImage(named: post.img)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 430)
        }
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
