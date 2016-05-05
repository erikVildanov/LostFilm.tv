//
//  SecondViewController.swift
//  LostFilm.tv
//
//  Created by Эрик Вильданов on 05.05.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

protocol tableViewControllerDelegate {
    
    func rssItemsSecond(rssItems: (title: String, description: String, pubDate: String))
    
}

class SecondViewController: UIViewController {
    

    @IBOutlet weak var secTitleLBl: UILabel!
    @IBOutlet weak var secPubDateLbl: UILabel!
    @IBOutlet weak var secDescriptionLbl: UILabel!
    @IBOutlet weak var secImageLbl: UIImageView!
    
    var delegate: tableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


//    func secTitle (rssItems: (title: String, description: String, pubDate: String)){
//        secTitleLBl.text = rssItems.title
//        secPubDateLbl.text = rssItems.pubDate
//        secImageLbl.image = UIImage(data: NSData(contentsOfURL:NSURL(string: rssItems.description)! )!)
//        
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
