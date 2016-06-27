//
//  Networking.swift
//  Networking
//
//  Created by Эрик Вильданов on 27.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit
import CoreData
import XCTest
@testable import LostFilm



class Networking: XCTestCase {
    
    var viewController: FilmTableViewController!
    
    override func setUp() {
        super.setUp()
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FilmTableViewController") as! FilmTableViewController
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    //мок объекты тесты (сетевую надо заменить мок объектом)
    //в парсере нужно выделить сетевой запрос и заменить его мок объетами
    func testOne(){
        let film = RssFilm()
        XCTAssert(film.description1 == "")
    }
    
    func testFilmTableHasTableViewPropertySetAfterLoading() {
        // given
        // 1
        let mockFilmTable = MockFilmTable()
        
        viewController.rssItems = mockFilmTable.loadFilm
        
        // when
        // 2
        XCTAssertNil(mockFilmTable.tableView, "Before loading the table view should be nil")
        
        // 3
        let _ = viewController.view
        mockFilmTable.tableView = viewController.tableView
        // then
        // 4
        XCTAssertTrue(mockFilmTable.tableView != nil, "The table view should be set")
        XCTAssert(mockFilmTable.tableView === viewController.tableView,
                  "The table view should be set to the table view of the data source")
    }
    
    func testListMatches(){
        let str = FeedParser()
        let s = str.listMatches("[a-z]+", inString: "qwert123QWERT")
        XCTAssertTrue(s=="qwert")
    }
    
    func testReplaceMatches(){
        let str = FeedParser()
        let s = str.replaceMatches("1", inString: "1234567", withString: "2")
        XCTAssertTrue(s == "2234567")
    }
    
    func testParser4(){

        let feedParser = FeedParser()
        let mock = MockFeedParser()
        
        feedParser.currentElement = "description"
        feedParser.parser(mock.data, foundCharacters: mock.mockDescription)
        XCTAssertTrue(feedParser.currentDescription == "http.1.jpg")
        
        feedParser.currentElement = "title"
        feedParser.parser(mock.data, foundCharacters: mock.mockTitle)
        XCTAssertTrue(feedParser.currentTitle == "TITLE")
        
        feedParser.currentElement = "pubDate"
        feedParser.parser(mock.data, foundCharacters: mock.mockPubDate)
        XCTAssertTrue(feedParser.currentPubDate == "27.06.16")
        
        feedParser.currentElement = "link"
        feedParser.parser(mock.data, foundCharacters: mock.mockLink)
        XCTAssertTrue(feedParser.currentLink == "www.vk.com")
    }
    
    func testParser5() {
        let feedParser = FeedParser()
        let mock = MockFeedParser()
        feedParser.parser(mock.data, didStartElement: mock.mockElement, namespaceURI: nil, qualifiedName: nil, attributes: ["version": "0.91"])
        XCTAssertTrue(feedParser.currentElement == "item" && feedParser.currentDescription == "" && feedParser.currentLink == "" && feedParser.currentPubDate == "" && feedParser.currentTitle == "")
    }
    
    class MockFeedParser: RssFilm, NSXMLParserDelegate {
        var data = NSXMLParser()
        var mockElement = "item"
        var mockTitle = "TITLE"
        var mockPubDate = "27.06.16"
        var mockDescription = "descri http.1.jpg ption"
        var mockLink = "www.vk.com"
        var mockRssItems: [RssFilm] = []
        
        
        
    }
    
    class MockFilmTable: UIViewController, UITableViewDataSource, UITabBarDelegate  {
        
        var loadFilm: [RssFilm] = []
        var rssFilmLoad = false
        weak var tableView: UITableView!
        func loadRssFilm() { rssFilmLoad = true}
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            return UITableViewCell()
        }

    }
    
}


