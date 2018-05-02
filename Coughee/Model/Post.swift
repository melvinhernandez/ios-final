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
    var date: Date
    
    init(username: String, item: String, shop: String, caffeine: Int, caption: String, dateString:String) {
        self.username = username
        self.item = item
        self.shop = shop
        self.caffeine = caffeine
        self.caption = caption
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.date = dateFormatter.date(from: dateString)!
    }
    
}
