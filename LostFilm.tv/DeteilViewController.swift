//
//  SecondViewController.swift
//  LostFilm.tv
//
//  Created by Эрик Вильданов on 05.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

protocol DeteilViewControllerProtocol {
    
    func rss(rssItem: RssFilm)
}

class DeteilViewController: UIViewController, DeteilViewControllerProtocol  {
    
    
 
    //@IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var secTitleLBl: UILabel!
    @IBOutlet weak var secPubDateLbl: UILabel!
    @IBOutlet weak var secImageLbl: UIImageView!
    
    @IBAction func secLink(sender: UIButton) {
        let url = NSURL(string: infoFilm.link)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func fullHD(sender: UIButton) {
        let url = NSURL(string: infoFilm.fullHD)
        UIApplication.sharedApplication().openURL(url!)
    }
    @IBAction func MP4(sender: UIButton) {
        let url = NSURL(string: infoFilm.MP4)
        UIApplication.sharedApplication().openURL(url!)
    }
    var infoFilm = RssFilm(title: "", description: "", pubDate: "", link: "", fullHD: "", MP4: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: infoFilm.description) {
            let request = NSURLRequest(URL:  url)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config,delegate: nil,
                                       delegateQueue:NSOperationQueue.mainQueue())
            let task = session.dataTaskWithRequest(request, completionHandler: {data, _, _ -> Void in
                if let data = data {
                    self.secImageLbl.image = UIImage(data: data)
                }
            })
            task.resume()
        }
        secTitleLBl.text = infoFilm.title
        secPubDateLbl.text = infoFilm.pubDate
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rss(rssItem: RssFilm) {
        infoFilm = rssItem
    }
    
}
