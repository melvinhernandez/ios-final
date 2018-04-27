//
//  MenuBar.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/12/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let menuBarItems = ["Info","Menu", "Posts"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.lightPastelBlue
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "menuBarItem"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        // Highlights & Selects the first menu bar item by default.
        let selectedItem = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedItem, animated: false, scrollPosition: [])
        // Setup bottom bar to show selection.
        setupHorizontalBar()
    }
    
    var coffeeShopContent: CoffeeShopContent?
    var horizontalBarX: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = Colors.darkGray
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBar)
        
        horizontalBarX = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        NSLayoutConstraint.activate([
            horizontalBarX!,
            horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            horizontalBar.heightAnchor.constraint(equalToConstant: 4)])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coffeeShopContent?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBarItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.shopTitle.text = menuBarItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(Int(frame.width) / menuBarItems.count), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MenuCell: BaseCollectionCell {
    
    let shopTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Colors.lightGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            shopTitle.textColor = isHighlighted ? Colors.darkGray : Colors.lightGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            shopTitle.textColor = isSelected ? Colors.darkGray : Colors.lightGray
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(shopTitle)
        addConstraintsWithFormat(format: "H:|[v0]|", views: shopTitle)
        addConstraintsWithFormat(format: "V:|[v0]|", views: shopTitle)
    }

}
