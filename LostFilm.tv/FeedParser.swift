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

     var rssItems : [RssFilm] = []
     var rssItem: RssFilmBuilder = RssFilmBuilder()
     var Element = ""
    
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
        rssItems = []
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        Element = elementName
        if Element == "item" {
            rssItem.startBuilder()
        }
            
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        switch Element {
            case "title" :
                rssItem.title += string.deleteSpase
            case "description" :
                var str = listMatches("http.*jpg", inString: string)
                str = replaceMatches("&\\#58;", inString: str, withString: "s:")!
                str = replaceMatches("&\\#46;", inString: str, withString: ".")!
            rssItem.filmDescription = str.deleteSpase
            case "pubDate" :
                rssItem.pubDate += listMatches("(................)", inString: string).deleteSpase
            case "link" :
                rssItem.link += string.deleteSpase
            default : break
            }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard elementName == "item" else { return }
        
        if let rssFilm = rssItem.endBuilder() {
            rssItems.append(rssFilm)
        }
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        self.parserCompletionHandler?(rssItems)
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
    
}
