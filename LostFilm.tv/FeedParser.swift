//
//  FeedParser.swift
//  работа
//
//  Created by Эрик Вильданов on 20.04.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

extension String{
    var deleteSpase: String {return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())}
}


class FeedParser: RssFilmBuilder, NSXMLParserDelegate {
     var collector : [RssFilm] = []
     var arrayRssItemFilm : [RssFilm] = []
     let rssItemFilmBuilder: RssFilmBuilder = RssFilmBuilder()
     var Element = ""
     var counter = 0
    private var parserCompletionHandler:([RssFilm] -> Void )?
    
    
    func parseFeed (feedUrl: String, completionHandler: ([RssFilm] -> Void)?) -> Void {
        
        self.parserCompletionHandler = completionHandler
        
        let request = NSURLRequest(URL: NSURL(string: feedUrl)!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request, completionHandler:{
            (data, respouse, error) -> Void in
            
            if error != nil {
                print("\(error?.localizedDescription)")
            }
            
            let parser = NSXMLParser(data: data!)
            parser.delegate = self
            parser.parse()
            
            
        })
        task.resume()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        arrayRssItemFilm = []
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        Element = elementName
        if Element == "item" && counter == 0 {
            rssItemFilmBuilder.startBuilder()
        }
            
    }
    
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        switch Element {
            case "title" :
                if counter < 1 {
                var str = replaceMatches(".\\[1080p].*|.\\[MP4].*.", inString: string, withString: ".")!
                    str = replaceMatches("\\(\\D\\d\\d\\D\\d\\d\\)", inString: str, withString: "")!
                rssItemFilmBuilder.title += str.deleteSpase
            }
            case "description" :
                if counter < 1 {
                var str = listMatches("http.*jpg", inString: string)
                str = replaceMatches("&\\#58;", inString: str, withString: "s:")!
                str = replaceMatches("&\\#46;", inString: str, withString: ".")!
            rssItemFilmBuilder.filmDescription = str.deleteSpase
            }
            case "pubDate" :
                if counter < 1 {
                rssItemFilmBuilder.pubDate += listMatches("(................)", inString: string).deleteSpase
            }
            case "link" :
                rssItemFilmBuilder.link += string.deleteSpase
                 if containsMatch("torrent", inString: rssItemFilmBuilder.link){
                if containsMatch("720p", inString: rssItemFilmBuilder.link){
                    rssItemFilmBuilder.MP4 = rssItemFilmBuilder.link.deleteSpase
                    rssItemFilmBuilder.link = ""
                } else
                if containsMatch("1080p", inString: rssItemFilmBuilder.link){
                    rssItemFilmBuilder.fullHD = rssItemFilmBuilder.link.deleteSpase
                    rssItemFilmBuilder.link = ""
                }
            }
            
            default : break
            }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard elementName == "item" else { return }
        counter += 1
        if counter == 3 {
        if let rssFilm = rssItemFilmBuilder.endBuilder() {
            arrayRssItemFilm.append(rssFilm)
            counter = 0
        }
        }
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        self.parserCompletionHandler?(arrayRssItemFilm)
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("\(parseError.localizedDescription)")
    }
    
    func listMatches(pattern: String, inString string: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: .AllowCommentsAndWhitespace)
        let range = NSMakeRange(0, string.characters.count)
        let matches = regex.firstMatchInString(string, options: .ReportCompletion, range: range)
        if matches != nil {
            return matches.map {
                let range = $0.range
                return (string as NSString).substringWithRange(range)
                }!
        } else { return string }
    }
    
    func replaceMatches(pattern: String, inString string: String, withString replacementString: String) -> String? {
        let regex = try! NSRegularExpression(pattern: pattern, options: .AllowCommentsAndWhitespace)
        let range = NSMakeRange(0, string.characters.count)
        
        return regex.stringByReplacingMatchesInString(string, options: .ReportCompletion, range: range, withTemplate: replacementString)
    }
    
    func containsMatch(pattern: String, inString string: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: .AllowCommentsAndWhitespace)
        let range = NSMakeRange(0, string.characters.count)
        return regex.firstMatchInString(string, options: .ReportCompletion, range: range) != nil
    }
    
}
