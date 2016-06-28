//
//  rssFilm.swift
//  LostFilm.tv
//
//  Created by Эрик Вильданов on 11.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

struct RssFilm {
    let title: String
    let description: String
    let pubDate: String
    let link: String
}

class RssFilmBuilder: NSObject {
    
    var title: String = ""
    var filmDescription: String = ""
    var pubDate: String = ""
    var link: String = ""
    var flagFulFilm: Bool = false
    
    override init() {
        title = ""
        filmDescription = ""
        pubDate = ""
        link = ""
    }
    
    init(title: String, description: String, pubDate: String, link: String){
        self.title = title
        self.filmDescription = description
        self.pubDate = pubDate
        self.link = link
    }
    
    func startBuilder(){
        flagFulFilm = true
        title = ""
        filmDescription = ""
        pubDate = ""
        link = ""
    }
    
    func endBuilder() -> RssFilm? {
        if flagFulFilm {
            flagFulFilm = false
            return RssFilm(title: title, description: filmDescription, pubDate: pubDate, link: link)
        } else {
            flagFulFilm = false
            return nil
        }
    }
}
