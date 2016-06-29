//
//  TableViewController.swift
//  работа
//
//  Created by Эрик Вильданов on 20.04.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

public class FilmTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    let dateFormatter = NSDateFormatter()
    let tableData = TableDataSource()
    
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
                (rssLinesFilm:[RssFilm]) -> Void in
                self.tableData.dataFilm = rssLinesFilm
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
}
