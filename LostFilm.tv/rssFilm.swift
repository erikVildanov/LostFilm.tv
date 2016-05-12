//
//  rssFilm.swift
//  LostFilm.tv
//
//  Created by Эрик Вильданов on 11.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit


class rssFilm: NSObject {
    var title:[String] = []
    var description1: [String] = []
    var pubDate: [String] = []
    //var mass: ([(title: String, description: String, pubDate: String)]) = []
    
    
    init(title: String, description: String, pubDate: String){
        self.title.append(title)// = title
        self.description1.append(description)// = description
        self.pubDate.append(pubDate)// = pubDate
    }
    init(rss: [(title: String, description: String, pubDate: String)]){
        for i in 0...rss.count-1{
        
        self.title.append(rss[i].title)// = title
        self.description1.append(rss[i].description)// = description
        self.pubDate.append(rss[i].pubDate)// = pubDate
        }
    }
    
    private func pars (rss: [(title: String, description: String, pubDate: String)]){
        for i in 0...rss.count{
            
        rssFilm(rss[i])
            
        }
    }
    
//    init(str : [(title: String, description: String, pubDate: String)]){
//        self.mass = str
//        
//    }
    
}


