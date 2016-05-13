//
//  TableViewController.swift
//  работа
//
//  Created by Эрик Вильданов on 20.04.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

//создать массив моделей, что бы не было rssItems в виде массива а массив класса

class tableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    //private var rssItems: [(title: String, description: String, pubDate: String)]?
    var rssItems: [RssFilm] = []
    private var tablData = [String]()
    private var tableViewController = UITableViewController(style: .Plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedParser = FeedParser()
        
        feedParser.parseFeed("https://www.lostfilm.tv/rssdd.xml", completionHandler:
            {
            (rssItems:[RssFilm]) -> Void in
            
            self.rssItems = rssItems
                
            if self.tableView != nil {
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
            })
            }
            
        })
//        self.refreshControl?.addTarget(self, action: #selector(TableViewController.didRefreshList), forControlEvents: .ValueChanged)
//        
//        self.refreshControl?.attributedTitle = NSAttributedString(string: "последнее обновление: \(NSDate())")

    }
    
//    func didRefreshList(){
//        let feedParser = FeedParser()
//        
//        feedParser.parseFeed("https://www.lostfilm.tv/rssdd.xml", completionHandler: {
//            (rssItems:[(title: String, description: String, pubDate: String)]) -> Void in
//            
//            self.rssItems = rssItems
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
//            })
//        })
//        self.refreshControl?.addTarget(self, action: #selector(TableViewController.didRefreshList), forControlEvents: .ValueChanged)
//        self.tableViewController.tableView.reloadData()
//        self.refreshControl?.endRefreshing()
//    }



    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //if let rss = self.rssItems{
        if let rss: [RssFilm] = self.rssItems{
            return rss.count
        } else {
            return 0
        }
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        if let item: RssFilm = rssItems[indexPath.row]{
            cell.titleLbl.text = item.title
            
            let url = NSURL(string: item.description1)
            let request = NSURLRequest(URL: url!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            (response: NSURLResponse?, data: NSData? , error: NSError?) -> Void in
            cell.img.image = UIImage(data: data!)
            }
            
            cell.pubDateLbl.text = item.pubDate
        }
        
        return cell
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//        if segue.identifier == "pushSecond" {
//            let destinationVC = segue.destinationViewController as! DeteilViewController
//            destinationVC.delegate = self
//            
//        }
//        
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
