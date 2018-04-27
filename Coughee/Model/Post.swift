//
//  Post.swift
//  Coughee
//
//  Created by Juan Cervantes on 4/22/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation

class Post {
    var username: String
    var item: String
    var shop: String
    var caffeine: Int
    var caption: String
    var date: String
    
    init(username: String, item: String, shop: String, caffeine: Int, caption: String, date:String) {
        self.username = username
        self.item = item
        self.shop = shop
        self.caffeine = caffeine
        self.caption = caption
        self.date = date
    }
    
}
