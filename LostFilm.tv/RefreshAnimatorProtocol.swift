//
//  RefreshAnimatorProtocol.swift
//  LostFilm
//
//  Created by Эрик Вильданов on 04.07.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

protocol RefreshAnimatorProtocol {
    func startAnimating()
    func endAnimating()
    func loadCustomRefreshContents(refreshContents: [UILabel])
}

class RefreshAnimating: RefreshAnimatorProtocol {
    
    var labelsArray: Array<UILabel> = []
    var currentColorIndex = 0
    var currentLabelIndex = 0
    
    func startAnimating() {
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {() -> Void in
            if self.currentLabelIndex < self.labelsArray.count {
                self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
                self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
            }
            }, completion: completionStart)
    }
    
    func endAnimating() {
        for i in 0..<labelsArray.count {
        labelsArray[i].layer.removeAllAnimations()
        }
    }
    func loadCustomRefreshContents(refreshContents: [UILabel]){
        
        labelsArray = refreshContents
    }
    
    private func getNextColor() -> UIColor {
        var colorsArray: Array<UIColor> = [UIColor.magentaColor(), UIColor.brownColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.orangeColor()]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex += 1
        
        return returnColor
    }
    
    private func completionStart(finished: Bool){
        UIView.animateWithDuration(0.05, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            if self.currentLabelIndex < self.labelsArray.count {
                self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformIdentity
                self.labelsArray[self.currentLabelIndex].textColor = UIColor.blackColor()
            }
            }, completion: completionStartFinished)
    }
    
    private func completionEnd(finished: Bool){
        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            for j in 0..<self.labelsArray.count{
                self.labelsArray[j].transform = CGAffineTransformIdentity
            }
            }, completion: completionEndFinished)
    }
    
    private func completionStartFinished(finished: Bool){
        if !finished {
            self.currentLabelIndex += 1
            
            if self.currentLabelIndex < self.labelsArray.count {
                self.startAnimating()
            }}
        else {
            self.endAnimat()
            self.currentLabelIndex = 0
        }
    }
    
    private func completionEndFinished(finished: Bool){
        if !finished {
            self.currentLabelIndex = 0
            self.startAnimating()
        }
        else {
            self.currentLabelIndex = 0
            for i in 0 ..< self.labelsArray.count {
                self.labelsArray[i].textColor = UIColor.blackColor()
                self.labelsArray[i].transform = CGAffineTransformIdentity
            }
        }
    }
    
    private func endAnimat() {
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            for i in 0..<self.labelsArray.count{
                self.labelsArray[i].transform = CGAffineTransformMakeScale(1.5, 1.5)
            }
            }, completion: completionEnd )
    }

    
}

