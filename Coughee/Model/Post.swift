//
//  Post.swift
//  Coughee
//
//  Created by Juan Cervantes on 4/22/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation

class Post {
    var name: String
    var item: String
    var shop: String
    var caffeine: String
    var caption: String
    var date: Date
    
    init(name: String, item: String, shop: String, caffeine: String, caption: String, date:Date) {
        self.name = name
        self.item = item
        self.shop = shop
        self.caffeine = caffeine
        self.caption = caption
        self.date = date
    }
    
}
