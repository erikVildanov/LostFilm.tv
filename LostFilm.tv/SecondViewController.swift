//
//  SecondViewController.swift
//  LostFilm.tv
//
//  Created by Эрик Вильданов on 05.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

protocol vcProtocol {
    func rss(rssItems: (title: String, description: String, pubDate: String))
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var secTitleLBl: UILabel!
    @IBOutlet weak var secPubDateLbl: UILabel!
    @IBOutlet weak var secDescriptionLbl: UILabel!
    @IBOutlet weak var secImageLbl: UIImageView!
    
     var delegate: vcProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secTitleLBl.lineBreakMode = NSLineBreakMode.ByWordWrapping
        secTitleLBl.numberOfLines = 0
        secTitleLBl.text = self.delegate.debugDescription
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rss(rssItems: (title: String, description: String, pubDate: String)) {
        secPubDateLbl.text = rssItems.pubDate
        secDescriptionLbl.text = rssItems.description
        secTitleLBl.text = rssItems.title
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
