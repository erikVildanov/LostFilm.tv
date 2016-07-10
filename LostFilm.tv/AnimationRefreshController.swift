//
//  AnimationController.swift
//  LostFilm
//
//  Created by Эрик Вильданов on 01.07.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit


class AnimationRefreshController: UIRefreshControl {
    
    let lable1 = UILabel()
    let lable2 = UILabel()
    let lable3 = UILabel()
    let lable4 = UILabel()
    let lable5 = UILabel()
    let lable6 = UILabel()
    let lable7 = UILabel()
    let str: Array<String> = ["R","E","F","R","E","S","H"]
    
    let animator: RefreshAnimatorProtocol
    init(animator: RefreshAnimatorProtocol) {
        self.animator = animator
        super.init()
        
        backgroundColor = UIColor.clearColor()
        tintColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        animator.startAnimating()
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        animator.endAnimating()
    }
    
    func loadCustomRefreshContents() {
        let customView = UIView()
        var labelsArray: Array<UILabel> = [lable1,lable2,lable3,lable4,lable5,lable6,lable7]
        
        var k: CGFloat = 57
        
        for i in 0..<labelsArray.count {
            labelsArray[i].translatesAutoresizingMaskIntoConstraints = false
            labelsArray[i].text = str[i]
            labelsArray[i].font = labelsArray[i].font.fontWithSize(20)
            customView.insertSubview(labelsArray[i], atIndex: 0)
            
            labelsArray[i].widthAnchor.constraintEqualToAnchor(nil, constant: 14.5).active = true
            
            let margins = customView.layoutMarginsGuide
            labelsArray[i].leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: k).active = true
            
            k += 30
            
            labelsArray[i].centerYAnchor.constraintEqualToAnchor(customView.centerYAnchor, constant: 57).active = true
            
        }
        addSubview(customView)
        animator.loadCustomRefreshContents(labelsArray)
        
    }

}
