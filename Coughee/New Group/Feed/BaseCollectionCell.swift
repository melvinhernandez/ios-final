//
//  BaseCollectionCell.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/12/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
