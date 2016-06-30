//
//  rssFilm.swift
//  LostFilm.tv
//
//  Created by Эрик Вильданов on 11.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

class RssFilmBuilder: NSObject {
    
    var title: String = ""
    var filmDescription: String = ""
    var pubDate: String = ""
    var link: String = ""
    var flagFulFilm: Bool = false
    var fullHD: String = ""
    var MP4: String = ""
    
    override init() {
        title = ""
        filmDescription = ""
        pubDate = ""
        link = ""
        fullHD = ""
        MP4 = ""
    }
    
    init(title: String, description: String, pubDate: String, link: String, fullHD: String, MP4: String){
        self.title = title
        self.filmDescription = description
        self.pubDate = pubDate
        self.link = link
        self.fullHD = fullHD
        self.MP4 = MP4
    }
    
    func startBuilder(){
        flagFulFilm = true
        title = ""
        filmDescription = ""
        pubDate = ""
        link = ""
        fullHD =  ""
        MP4 = ""
    }
    
    func endBuilder() -> RssFilm? {
        if flagFulFilm {
            flagFulFilm = false
            return RssFilm(title: title, description: filmDescription, pubDate: pubDate, link: link, fullHD: fullHD, MP4: MP4)
        } else {
            flagFulFilm = false
            return nil
        }
    }
}
