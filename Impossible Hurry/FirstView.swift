//
//  FirstView.swift
//  Impossible Hurry
//
//  Created by mhtran on 2/11/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import UIKit
import Foundation
import GoogleMobileAds

class FirstView: UIViewController{
    var credit: UILabel?
    var vc = ViewController()
    var vcapp = MyApp()
    var button0 = UIButton()
    var button1 = UIButton()
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        button0.enabled = false
        let centerP = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2)
        let backGround = UIImageView(frame: CGRect(x: 0, y: 0, width: centerP.x * 2, height: centerP.y * 2))
        backGround.image = UIImage(named: "new icon-01.png")
        backGround.center = CGPoint(x: centerP.x, y: centerP.y * 6/7)
        self.view.addSubview(backGround)
        button0 = UIButton(frame: CGRectMake(20, 30, 45, 45))
        let imageb0 = UIImage(named: "Remove_advertise.png") as UIImage!
        button0.center = CGPoint(x: centerP.x - 90, y: centerP.y * 50/51 + 160)
        button0.setBackgroundImage(imageb0, forState: .Normal)
        button0.addTarget(self, action: "touchRemoveAds", forControlEvents: UIControlEvents.TouchUpInside)
        
        button1 = UIButton(frame: CGRectMake(20, 30, 60, 60))
        let imageb1 = UIImage(named: "Play0.png") as UIImage!
        button1.center = CGPoint(x: centerP.x, y: centerP.y * 50/51 + 160)
        button1.setBackgroundImage(imageb1, forState: .Normal)
        button1.addTarget(self, action: "touchPlay", forControlEvents: UIControlEvents.TouchUpInside)
        UIView.animateWithDuration(0.6 ,delay:0, options: [.Repeat, .Autoreverse, .TransitionCrossDissolve, .AllowUserInteraction], animations: {
                self.button1.transform = CGAffineTransformMakeScale(0.6, 0.6)
            },
            completion: { finish in
                UIView.animateWithDuration(0.6){
                    self.button1.transform = CGAffineTransformIdentity
                }
        })
        self.view.addSubview(button1)
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        credit = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        credit?.text = "credit by abtranbn"
        
        credit?.textAlignment = NSTextAlignment.Center
        credit?.center = CGPoint(x: centerP.x , y: centerP.y * 2 - 50)
        credit?.font = UIFont (name: "Zapfino", size: 8)
        self.view.addSubview(credit!)
        let banner = GADBannerView(frame: CGRect(x: 0,y:0, width: self.view.frame.width, height: 50))
        banner.adUnitID = "ca-app-pub-6539656833486891/1890916167"
        banner.rootViewController = self
        banner.loadRequest(GADRequest())
        self.view.addSubview(banner)
        

    }
    
    func touchPlay() {
        self.presentViewController(ViewController(), animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
}
