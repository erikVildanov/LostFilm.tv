//
//  FullImageView.swift
//  LostFilm
//
//  Created by Эрик Вильданов on 08.07.16.
//  Copyright © 2016 Эрик Вильданов. All rights reserved.
//

import UIKit

class FullImageView: UIImageView, UIScrollViewDelegate {
    
    var fullscreenImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.userInteractionEnabled = true
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(showFullscreen))
        self.addGestureRecognizer(touchGesture)
    }
    
    private func createFullscreenPhoto() -> UIImageView {
        
        let tmpImageView = UIImageView(frame: self.frame)
        tmpImageView.image = self.image
        tmpImageView.contentMode = UIViewContentMode.ScaleAspectFit
        tmpImageView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        tmpImageView.alpha = 0.0
        tmpImageView.userInteractionEnabled = true

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(hideFullscreen))
        swipe.direction = [.Down, .Up]
        tmpImageView.addGestureRecognizer(swipe)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideFullscreen))
        tmpImageView.addGestureRecognizer(tap)
        
        return tmpImageView
    }
    
    
    func showFullscreen() {
        
        let window = UIApplication.sharedApplication().windows.first!
            
            self.fullscreenImageView = createFullscreenPhoto()
            
            window.addSubview(self.fullscreenImageView)
            UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseInOut, animations: {
                
                self.fullscreenImageView.frame = window.frame
                self.fullscreenImageView.alpha = 1
                self.fullscreenImageView.layoutSubviews()
                
                }, completion: { _ in
            })
    }
    
    func hideFullscreen() {
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseInOut, animations: {
            
            self.fullscreenImageView?.frame = self.frame
            self.fullscreenImageView?.alpha = 0
            
            }, completion: { finished in
                
                self.fullscreenImageView?.removeFromSuperview()
                self.fullscreenImageView = nil
        })
    }
    
    
    
}
