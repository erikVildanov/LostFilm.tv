//
//  TableDataSource.swift
//  LostFilm
//
//  Created by Эрик Вильданов on 28.06.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

class TableDataSource: NSObject, UITableViewDataSource {
    var dataFilm = FeedParser()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataFilm.rssItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        if let item: RssFilm = dataFilm.rssItems[indexPath.row]{
            cell.titleLbl.text = item.title
            
            let url = NSURL(string: item.description)
            let request = NSURLRequest(URL: url!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
                (response: NSURLResponse?, data: NSData? , error: NSError?) -> Void in
                
                cell.img.image = UIImage(data: data!)
            }
            
            cell.pubDateLbl.text = item.pubDate
        }
        
        return cell
    }
    
}