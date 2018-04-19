//
//  CoffeeShopInfoViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/12/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class CoffeeShopContent: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let contentStuff = ["Coffee Shop", "Posts"]
    let cellId = "coffeeShopContent"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .green
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    // This is the menu bar to switch between coffee shop info and posts.
    lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.coffeeShopContent = self
        return menu
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        setupMenuBar()
    }
    
    func setupCollectionView() {
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView.isPagingEnabled = true
    }
    
    func setupMenuBar() {
        collectionView.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            menuBar.topAnchor.constraint(equalTo: self.topAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let indexPath = IndexPath(item: Int(targetContentOffset.pointee.x / self.frame.width), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentStuff.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContentCell
        cell.stuffTitle.text = contentStuff[indexPath.item]
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarX?.constant = scrollView.contentOffset.x / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContentCell: BaseCollectionCell {
    
    let stuffTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Colors.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(stuffTitle)
        addConstraintsWithFormat(format: "H:|[v0]|", views: stuffTitle)
        addConstraintsWithFormat(format: "V:|[v0]|", views: stuffTitle)
    }
    
}

