//
//  MyApp.swift
//  Impossible Hurry
//
//  Created by mhtran on 2/25/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import Foundation
import UIKit

class MyApp: UIViewController, UIScrollViewDelegate {
    var viewRect: CGRect!
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    weak var scrollView: UIScrollView!
//    var vcc = FirstView()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewRect = self.view.bounds
        self.viewWidth = viewRect.size.width
        self.viewHeight = viewRect.size.height
        self.view.backgroundColor = UIColor.whiteColor()
        var centerP = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2)
        var title = UILabel(frame: CGRect(x: centerP.x / 3, y: 30, width: 190, height: 20))
        title.text = "Try my best app"
        title.textAlignment = NSTextAlignment.Center
        self.view.addSubview(title)
        var app1 = UIButton()
        app1 = UIButton(frame: CGRectMake(20, 30, 60, 60))
        var image_app1 = UIImage(named: "App1.png") as UIImage!
        app1.center = CGPoint(x: centerP.x / 3.5, y: 60)
        app1.setBackgroundImage(image_app1, forState: .Normal)
        app1.addTarget(self, action: "touchApp1", forControlEvents: UIControlEvents.TouchUpInside)
        app1.layer.cornerRadius = 5
        app1.clipsToBounds = true
        var back = UIButton()
        back = UIButton(frame: CGRectMake(20, 30, 40, 40))
        var image_back = UIImage(named: "back.png") as UIImage!
        back.center = CGPoint(x: centerP.x / 5, y: centerP.y * 2 - 30)
        back.setBackgroundImage(image_back, forState: .Normal)
        back.addTarget(self, action: "touchBack", forControlEvents: UIControlEvents.TouchUpInside)
        var titlea1 = UILabel(frame: CGRect(x: centerP.x / 10, y: 165, width: 190, height: 90))
        titlea1.text = "Snake"
        titlea1.center = CGPoint(x: centerP.x / 3.5, y: 100)
        titlea1.textAlignment = NSTextAlignment.Center
        var titlea1a = UILabel(frame: CGRect(x: centerP.x / 10, y: 165, width: 190, height: 90))
        titlea1a.text = "2025"
        titlea1a.center = CGPoint(x: centerP.x / 3.5, y: 115)
        titlea1a.textAlignment = NSTextAlignment.Center
        // Do any additional setup after loading the view.
        var scrollView = UIScrollView(frame: viewRect)
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(self.viewWidth, self.viewHeight)
        self.view.addSubview(scrollView)
        self.scrollView = scrollView
        var subScrollView = UIScrollView(frame: CGRect(x: 0, y: 50, width: centerP.x * 2, height: centerP.y * 2 - 20))
        subScrollView.pagingEnabled = true
        subScrollView.contentSize = CGSizeMake(self.viewWidth, self.viewHeight)
        subScrollView.addSubview(app1)
        subScrollView.addSubview(titlea1)
        subScrollView.addSubview(titlea1a)
        self.view.addSubview(back)
        self.scrollView.addSubview(subScrollView)
    }
    func touchApp1() {
        var url:NSURL? = NSURL(string: "itms-apps://itunes.apple.com/app/id964749497")
        UIApplication.sharedApplication().openURL(url!)
    }
    

    
    func touchBack() {
        self.dismissViewControllerAnimated(true, completion: nil);
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
//        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
    
    
    
    
}
