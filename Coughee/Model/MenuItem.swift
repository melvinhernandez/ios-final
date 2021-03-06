//
//  MenuItem.swift
//  Coughee
//
//  Created by Juan Cervantes on 4/21/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation

class MenuItem {
    var name: String
    var caffeine: Int
    var size: String
    var isHot: Bool
    var type: String
    
    init(name: String, caffeine: Int, size: String, isHot: Bool, type:String) {
        self.name = name
        self.caffeine = caffeine
        self.size = size
        self.isHot = isHot
        self.type = type
    }
    
}
