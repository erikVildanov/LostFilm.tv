//
//  rssFilm.swift
//  LostFilm.tv
//
//  Created by Эрик Вильданов on 11.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit


class rssFilm {
    var title:String = ""
    var description: String = ""
    var pubDate: String = ""
    var mass: ([(title: String, description: String, pubDate: String)]) = []
    
    
    init(title: String, description: String, pubDate: String){
        self.title = title
        self.description = description
        self.pubDate = pubDate
    }
    
    init(str : [(title: String, description: String, pubDate: String)]){
        self.mass = str
        
    }
    
}


