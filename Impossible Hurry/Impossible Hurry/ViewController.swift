//
//  ViewController.swift
//  Impossible Hurry
//
//  Created by mhtran on 2/7/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import Social

class ViewController: UIViewController,STADelegateProtocol {
    
    var startAppAd: STAStartAppAd?
    var startAppBanner: STABannerView?
    var hv, bi, gameOver: UIImageView?
    var xoay = M_PI_2 * 0
    var vY : Double = 0
    var timer: NSTimer?
    var delTa : Double = 0.008
    var t: Double = 0.025
    var d: Int = 0
    var chamhv: Bool?
    var imageIndex: Int?
    var score, hightScore: NSNumber?
    var scoretg: Int?
    
    var scoreLabel,heightScoreLable: UILabel?
    let imagefull = ["red.png", "blue.png", "green.png", "yelow.png"]
    var audioPlayer = AVAudioPlayer()
    var alert = UIAlertView()
    
    var startAppAdAutoLoad: STAStartAppAd?
    var startAppAdLoadShow: STAStartAppAd?
    var startAppBannerAuto: STABannerView?
    var startAppBannerFixed: STABannerView?


    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var centerP = CGPoint(x: self.view.bounds.size.width, y: self.view.bounds.size.height)

        startAppAd = STAStartAppAd()
        startAppAdAutoLoad = STAStartAppAd()
        startAppAdLoadShow = STAStartAppAd()
        alert.delegate = self
        var size = self.view.bounds.size
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        gameOver = UIImageView(frame: CGRect(x: size.width * 0.5, y: size.height * 0.5, width: size.width - 80, height: size.height - 300))
        bi = UIImageView(frame: CGRect(x:0  , y:0 , width: 30, height: 30))
        bi?.center = CGPoint(x: size.width * 0.5, y: 0)
        imageIndex = Int(arc4random_uniform(UInt32(imagefull.count)))
        bi?.image = UIImage(named: imagefull[Int(imageIndex!)])
        self.view.addSubview(bi!)
        hv = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width - 200, height: size.width - 200))
        hv?.center = CGPoint(x: size.width * 0.5, y: size.height * 7/16 + 150)
        NSLog("\(size.height - 180)")
        hv?.image = UIImage(named: "hv.png")
        self.view.addSubview(hv!)
        score = 0
        scoreLabel = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        scoreLabel!.text = "0"
        scoreLabel!.textAlignment = NSTextAlignment.Center
        scoreLabel?.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.view.addSubview(scoreLabel!)
        scoreLabel?.center.x = 30
        scoreLabel?.center.y = 30
        //
        
        var highScoretg : NSNumber? = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        heightScoreLable = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        //        NSLog("\(hightScore!)")
        heightScoreLable?.text =  highScoretg!.stringValue
        heightScoreLable?.textAlignment = NSTextAlignment.Center
        heightScoreLable?.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.view.addSubview(heightScoreLable!)
        heightScoreLable?.center.x = size.width - 30
        heightScoreLable?.center.y = 30
        //
        chamhv = false
//        d = 0
        startGame()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var centerP = CGPoint(x: self.view.bounds.size.width, y: self.view.bounds.size.height)
        startAppAd!.loadAd()
        startAppAdAutoLoad!.loadAd()
        if (startAppBannerAuto == nil) {
            startAppBannerAuto = STABannerView(size: STA_AutoAdSize, autoOrigin: STAAdOrigin_Bottom, withView: self.view, withDelegate: nil);
            self.view.addSubview(startAppBannerAuto!)
        }
        
        /*
        load the StartApp fixed position banner - in (0, 200)
        NOTE: replace the ApplicationID and the PublisherID with your own IDs
        */
//        if (startAppBannerFixed == nil) {
//            if (UIDevice.currentDevice().userInterfaceIdiom == .Pad) {
//                startAppBannerFixed = STABannerView(size: STA_PortraitAdSize_768x90, origin: CGPointMake(0,centerP.y - 300), withView: self.view, withDelegate: nil)
//            } else {
//                startAppBannerFixed = STABannerView(size: STA_PortraitAdSize_320x50, origin: CGPointMake(0,centerP.y - 300), withView: self.view, withDelegate: nil)
//            }
//            
////            self.view.addSubview(startAppBannerFixed!)
//        }

    }
    
    func startGame() {
        score = 0
        if (self.timer != nil) {
            return
        }
        let tap = UITapGestureRecognizer(target: self, action: "onTap:")
        self.view.addGestureRecognizer(tap)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(t, target: self, selector: "biRoi:", userInfo: nil, repeats: true)
        
    }
    
    //tao am thanh khi bi roi dung mau hv
    
    //bi roi xuong voi gia toc trong truong
    func biRoi(timer: NSTimer) {
        //tinh van toc tai thoi diem t
        vY += 9.8 * delTa
        var y1 = Double(bi!.center.y) + vY
        bi!.center = CGPoint(x: bi!.center.x, y: CGFloat(y1))
//        NSLog("\n Biroi")
//        NSLog("\n vien \(Double(hv!.center.y - hv!.bounds.size.height * 0.5 + 60)) ")
//        NSLog( "\n bi mau so \(imageIndex!) ")
        // kiem tra xem bi cham hv
        
        if(!chamhv!) {
            if (y1 - 10 >= Double(hv!.center.y - hv!.bounds.size.height * 0.5 + bi!.bounds.size.width * 0.5)) {
                chamhv = true
                //kiem tra mau bi vs mau hv
                
                if (imageIndex! == Int(((xoay / M_PI_2) % 4))) {
                    xoay = Double(imageIndex!) * M_PI_2
//                    NSLog("\n \(imageIndex)")
//                    NSLog("\n \(Int(((xoay / M_PI_2) % 4)))")
//                    NSLog("\n bi cung mau hv")
                    AudioScrore()
                    reset()
                } else {
//                    NSLog("\n \(imageIndex!)")
//                    NSLog("\n \(Int(((xoay / M_PI_2) % 4)))")
//                    NSLog("\n bi khac mau")
                    stop()
                    
                }
            }
        }
        
    }
    
    func AudioScrore() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("point", ofType: "wav")!)
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func AudioGameOver() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("gameover", ofType: "mp3")!)
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    
    func reset() {
        NSTimer.scheduledTimerWithTimeInterval(t, target: self, selector: "reset1:", userInfo: nil, repeats: false)
    }
    
    func reset1 (_timer: NSTimer?) {
        var size = self.view.bounds.size
        //goi lai bi ve vi tri dau vs chay tiep
        bi?.center = CGPoint(x: size.width * 0.5, y: 0)
        imageIndex = Int(arc4random_uniform(UInt32(imagefull.count)))
        bi?.image = UIImage(named: imagefull[Int(imageIndex!)])
        self.view.addSubview(bi!)
        self.view.addSubview(hv!)
        chamhv = false
        vY = 0
        timer?.invalidate()
        // tang toc do bi roi len dan theo thoi gian
        t -= 0.00045
        timer = NSTimer.scheduledTimerWithTimeInterval(t, target: self, selector: "biRoi:", userInfo: nil, repeats: true)
        score = Int(score!) + 1
//        scoretg = Int(score!) * 1
        scoreLabel!.text = score!.stringValue
    }
    
    func highScore() -> Int
    {
        var highScore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        
        //Check if score is higher than NSUserDefaults stored value and change NSUserDefaults stored value if it's true
        var scoretg: Int = Int(score!) * 1
        if scoretg > highScore
        {
            NSUserDefaults.standardUserDefaults().setInteger(scoretg, forKey: "highscore")
            NSUserDefaults.standardUserDefaults().synchronize()
            highScore = scoretg
        }
        return highScore;
    }
    
    func stop () {
        // dung game lai bang ham gameOver
        timer?.invalidate()
//        self.dismissViewControllerAnimated(true, completion: nil)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "gameOver:", userInfo: nil, repeats: false)
//        NSLog("\n dung game")
        vY = 0
    }
    
    func gameOver(_timer: NSTimer) {
        
        NSLog("gia tri d = \(d)")
        if ( d == 4 ) {
            startAppAdLoadShow!.loadAd(STAAdType_Automatic, withDelegate: self)
//            startAppAd!.showAd()
            d = 0
        }
        else {
            d += 1
        }
        var size = self.view.bounds.size
        gameOver = UIImageView(frame: CGRect(x: size.width * 0.5, y: size.height * 0.5, width: 130, height: 135))
        gameOver?.center = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
        gameOver?.image = UIImage(named: "gameOver.png")
        self.view.addSubview(gameOver!)
//        NSLog("\n hien game over banner")
        AudioGameOver()
        highScore()
//        NSLog("\(highScore())")
        var highScoretg : NSNumber? = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        heightScoreLable?.text = highScoretg!.stringValue
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        screenShotMethod()
        showResult()
        
        
        
    }
    
    func showResult(){

        alert.title = "Game over! Your score is \(score!.stringValue)."
        alert.message = "To continue playing, hit 'Play Again'"
        alert.addButtonWithTitle("Share Facebook")
        alert.addButtonWithTitle("Share Twitter")

        alert.addButtonWithTitle("Play Again")
        alert.addButtonWithTitle("End Game")
        
        alert.show()
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex{
        case 1:
            NSNotificationCenter.defaultCenter().postNotificationName("tweet", object: nil)
            
            self.showTweetSheet()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweet", name: "tweet", object: nil)
            break;
            
        case 0:
            NSNotificationCenter.defaultCenter().postNotificationName("facebook", object: nil)
            self.showFaceBook()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "facebook", name: "facebook", object: nil)
            
            break;
            
        case 3:
            self.dismissViewControllerAnimated(true, completion: nil)
            
            break;
        case 2:
            
            self.resetGame()
            
            break;
        default:
            break;
            
        }}
    func onTap(tap : UITapGestureRecognizer) {
        xoay = xoay + M_PI_2
        self.hv!.transform = CGAffineTransformMakeRotation(CGFloat(xoay))
//        NSLog("\n tap \(xoay/M_PI_2)")
    }
    
    func resetGame() {
        t = 0.025
        var size = self.view.bounds.size
        gameOver = UIImageView(frame: CGRect(x: size.width * 0.5, y: size.height * 0.5, width: 130, height: 130))
        gameOver?.center = CGPoint(x: size.width * 0.5, y: size.height * 0.28)
        gameOver?.image = UIImage(named: "gameOverBlank.png")
        self.view.addSubview(gameOver!)
        startGame()
        
        score = -1
        reset()
//        NSLog("Bat dau choi lai")
        
    }
    
    func showFaceBook() {
        let facebook = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebook.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                self.showResult()
                //Add code to deal with it being cancelled
//                break
                
            case SLComposeViewControllerResult.Done:
                self.showResult()
                //Add code here to deal with it being completed
                //Remember that dimissing the view is done for you, and sending the tweet to social media is automatic too. You could use this to give in game rewards?
//                break
            }
        }
        
        facebook.setInitialText("Oh my god! Score in game \"Impossible Harry\" is \(score!.stringValue).") 
        facebook.addImage(self.screenShotMethod()) //Add an image if you like?
        facebook.addURL(NSURL(string: "https://www.facebook.com/pages/Impossible-Hurry/594745650627211?skip_nax_wizard=true&ref_type=logout_gear")) //A url which takes you into safari if tapped on
        
        self.presentViewController(facebook, animated: false, completion: {

        })

    }
    
    func showTweetSheet() {
        let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        tweetSheet.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                //Add code to deal with it being cancelled
                self.showResult()
                
            case SLComposeViewControllerResult.Done:
                //Add code here to deal with it being completed
                //Remember that dimissing the view is done for you, and sending the tweet to social media is automatic too. You could use this to give in game rewards?
                self.showResult()
            }
        }
        
        tweetSheet.setInitialText("Oh my god! Score in game \"Impossible Hurry\" is \(score!.stringValue).") //The default text in the tweet
        tweetSheet.addImage(self.screenShotMethod()) //Add an image if you like?
        tweetSheet.addURL(NSURL(string: "https://twitter.com/mhtranbn")) //A url which takes you into safari if tapped on
        
        self.presentViewController(tweetSheet, animated: false, completion: {
            //Optional completion statement
        })
    }

    
    func screenShotMethod() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(UIScreen.mainScreen().bounds.size, false, 0);
        self.view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        var image:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    override func  didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation)  {
        // notify StartApp auto Banner orientation change
        startAppBannerAuto!.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        
        // notify StartApp fixed position Banner orientation change
        startAppBannerFixed!.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
    }
    
    func didLoadAd(ad: STAAbstractAd) {
        //        println("StartApp Ad had been loaded successfully")
        startAppAdLoadShow!.showAd()
    }
    
    // StartApp Ad failed to load
    func failedLoadAd(ad: STAAbstractAd, withError error: NSError) {
        //        println("StartApp Ad had failed to load")
    }
    
    // StartApp Ad is being displayed
    func didShowAd(ad: STAAbstractAd) {
        //        println("StartApp Ad is being displayed")
    }
    
    // StartApp Ad failed to display
    func failedShowAd(ad: STAAbstractAd, withError error: NSError) {
        //        println("StartApp Ad is failed to display")
    }
    
    // StartApp Ad is being displayed
    func didCloseAd(ad: STAAbstractAd) {
        //        println("StartApp Ad was closed")
    }
    
    // StartApp Ad is being displayed
    func didClickAd(ad: STAAbstractAd) {
        //        println("StartApp Ad was clicked")
    }




}





