//
//  TableViewController.swift
//  работа
//
//  Created by Эрик Вильданов on 20.04.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

class FilmTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let dateFormatter = NSDateFormatter()
    let tableData = TableDataSource()
    var refresh: AnimationRefreshController!
    
    func refreshTable(){        // set up the refresh control
        refresh.addTarget(self, action: #selector(FilmTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refresh, atIndex: 2)
        
        refresh.loadCustomRefreshContents()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = AnimationRefreshController(animator: RefreshAnimating())
        refreshTable()
        loadRssFilm {
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Right)
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
        refresh.beginRefreshing()
        loadRssFilm {
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            self.refresh.endRefreshing()
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let destinationVC = segue.destinationViewController as! DeteilViewControllerProtocol
            let indexPath = self.tableView.indexPathForSelectedRow?.row
            destinationVC.rss(tableData.dataFilm[indexPath!])
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
}
