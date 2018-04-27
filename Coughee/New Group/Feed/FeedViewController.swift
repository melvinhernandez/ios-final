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
        let dbRef = Database.database().reference()
        dbRef.child("Posts").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    print(posts)
                    for (_, val) in posts {
                        print(val)
                        let post = val
                        let newPost = Post(username: post["username"]! as! String, item: post["menuItem"]! as! String, shop: post["coffeeShop"]! as! String, caffeine: post["caffeine"]! as! Int, caption: post["caption"]! as! String, date: post["date"]! as! String)
                        print(newPost.username)
                        self.postsArray.append(newPost)
                    }
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
        cell.timeLabel.text = post.date
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    func setupViews() {
//        logout.translatesAutoresizingMaskIntoConstraints = false
    }
}
