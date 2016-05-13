//
//  rssFilm.swift
//  LostFilm.tv
//
//  Created by Эрик Вильданов on 11.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit


class RssFilm: NSObject {
    var title:String
    var description1: String
    var pubDate: String
    
     override init() {
        self.title = ""
        self.description1 = ""
        self.pubDate = ""
    }
    
    init(title: String, description: String, pubDate: String){
        self.title = title
        self.description1 = description
        self.pubDate = pubDate
    }

    
}


