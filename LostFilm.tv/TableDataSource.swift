//
//  TableDataSource.swift
//  LostFilm
//
//  Created by Эрик Вильданов on 28.06.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

class TableDataSource: NSObject, UITableViewDataSource, NSURLSessionDelegate {
    var dataFilm: [RssFilm] = []
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataFilm.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            as! TableViewCell
        
        let item: RssFilm = dataFilm[indexPath.row]
            cell.titleLbl.text = item.title
        
            if let url = NSURL(string: item.description) {
                let request = NSURLRequest(URL:  url)
                let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                let session = NSURLSession(configuration: config,delegate: self,
                                           delegateQueue:NSOperationQueue.mainQueue())
                 let task = session.dataTaskWithRequest(request, completionHandler: {data, _, _ -> Void in
                    if let data = data {
                    cell.img.image = UIImage(data: data)
                    }
                })
                task.resume()
        }
            cell.pubDateLbl.text = item.pubDate
        return cell
    }
}