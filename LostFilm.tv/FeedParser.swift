//
//  FeedParser.swift
//  работа
//
//  Created by Эрик Вильданов on 20.04.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit



class FeedParser: NSObject, NSXMLParserDelegate {

    private var rssItems : [(title: String, description: String, pubDate: String)] = []
    
    private var currentElement = ""
    private var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }
    private var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }
    private var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }
    
    private var parserCompletionHandler:([(title: String, description: String, pubDate: String)] -> Void )?
    
    func parseFeed (feedUrl: String, completionHandler: ([(title: String, description: String, pubDate: String)] -> Void)?) -> Void {
        
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
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
        
    }
    var str = ""
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        var str = string
        switch currentElement {
            case "title" : currentTitle += str
            case "description" :
            var str: Array = [String](count: string.characters.count, repeatedValue: "")
            var k=0
            var j = 0
            var boo = false
            var boo1 = true
            for i in string.characters {
                str[k] = String(i)
                k += 1
            }
            if str.count>2 {
                while j<str.count-2 {
                if str[j] == "s" && str[j+1] == "r" && str[j+2] == "c" {
                    j = j + 5
                    boo = true
                }
                if boo {
                if str[j] == "\u{0022}" {break}
                else {
                    if (str[j] == "&") {
                        if boo1 {
                        currentDescription += "s:"
                        boo1 = false
                        j = j + 5
                        } else {
                            currentDescription += "."
                            j = j + 5
                        }
                    }
                    currentDescription += String(str[j])
                }
                }
                    j += 1
            }
            }
            
            case "pubDate" :
            var pub:Array = [String](count: string.characters.count, repeatedValue: "")
            var k=0
            for i in string.characters{
                pub[k]=String(i)
                k += 1
            }
             str = ""
            if pub.count>1{
                for i in 5...16{
                    str += String(pub[i])
                }
            }
            currentPubDate += str
        default : break
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            let rssItem = (title: currentTitle, description: currentDescription, pubDate: currentPubDate)
            
            rssItems += [rssItem]
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        self.parserCompletionHandler?(rssItems)
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("\(parseError.localizedDescription)")
    } 
    
}
