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
    
    @IBOutlet weak var secTitleLBl: UILabel!
    @IBOutlet weak var secPubDateLbl: UILabel!
    @IBOutlet weak var secDescriptionLbl: UILabel!
    @IBOutlet weak var secImageLbl: UIImageView!
    
    
    //var delegate: DeteilViewControllerProtocol?
    
    var infoFilm = RssFilm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secTitleLBl.text = infoFilm.title
        secDescriptionLbl.text = infoFilm.description1
        secPubDateLbl.text = infoFilm.pubDate
        let url = NSURL(string: infoFilm.description1)
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            (response: NSURLResponse?, data: NSData? , error: NSError?) -> Void in
            let cv:CGSize = CGSizeMake(100, 100)
            self.secImageLbl.sizeThatFits(cv)
            self.secImageLbl.image = UIImage(data: data!)
        }
        
        //secImageLbl.image = UIImage(data: NSData(contentsOfURL: url!)!)
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
