//
//  PostsViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/10/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "postCell"
    
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    func setupViews() {
//        logout.translatesAutoresizingMaskIntoConstraints = false
    }
}
