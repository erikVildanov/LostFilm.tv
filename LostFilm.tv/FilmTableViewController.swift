//
//  TableViewController.swift
//  работа
//
//  Created by Эрик Вильданов on 20.04.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

public class FilmTableViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var rssItems: [RssFilm] = []
    var refreshControl = UIRefreshControl()
    var dateFormatter = NSDateFormatter()
    var tableData = TableDataSource()
    
    func refreshTable(){        // set up the refresh control
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(FilmTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView?.addSubview(refreshControl)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        refreshTable()
        loadRssFilm {
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
        }
        tableView.dataSource = tableData
    }
    
    func loadRssFilm(completion: (Void -> Void)?){
        let feedParser = FeedParser()
        
        feedParser.parseFeed("https://www.lostfilm.tv/rssdd.xml", completionHandler:
            {
                (rssItems:[RssFilm]) -> Void in
                self.tableData.dataFilm = rssItems
                    dispatch_async(dispatch_get_main_queue(), {
                        completion?()
                    })
        })
    }
    
    func refresh(sender:AnyObject) {
        loadRssFilm {
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
        }
        if self.refreshControl.refreshing
        {
            self.refreshControl.endRefreshing()
        }
    }

    
        override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
                let destinationVC = segue.destinationViewController as! DeteilViewControllerProtocol
                let indexPath = self.tableView.indexPathForSelectedRow?.row
                
                destinationVC.rss(tableData.dataFilm[indexPath!])
            
    
        }
    

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
