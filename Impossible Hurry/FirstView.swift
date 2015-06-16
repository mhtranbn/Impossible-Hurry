//
//  FirstView.swift
//  Impossible Hurry
//
//  Created by mhtran on 2/11/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

import UIKit
import Foundation
//import StoreKit



//class FirstView: UIViewController,SKProductsRequestDelegate, SKPaymentTransactionObserver {
class FirstView: UIViewController{
    var credit: UILabel?
    var vc = ViewController()
    var vcapp = MyApp()
    var button0 = UIButton()
//    var backGvar centerP = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2)round: UIImageView?
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button0.enabled = false
        
        var centerP = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2)
        var backGround = UIImageView(frame: CGRect(x: 0, y: 0, width: centerP.x * 2, height: centerP.y * 2))
        backGround.image = UIImage(named: "new icon-01.png")
        backGround.center = CGPoint(x: centerP.x, y: centerP.y * 6/7)
        self.view.addSubview(backGround)
        
        
        button0 = UIButton(frame: CGRectMake(20, 30, 45, 45))
        var imageb0 = UIImage(named: "Remove_advertise.png") as UIImage!
        button0.center = CGPoint(x: centerP.x - 90, y: centerP.y * 50/51 + 160)
        button0.setBackgroundImage(imageb0, forState: .Normal)
        button0.addTarget(self, action: "touchRemoveAds", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(button0)
        
//        var button2 = UIButton()
//        button2 = UIButton(frame: CGRectMake(20, 30, 40, 40))
//        var imageb2 = UIImage(named: "My_app.png") as UIImage!
//        button2.center = CGPoint(x: centerP.x + 90, y: centerP.y * 50/51 + 160)
//        button2.setBackgroundImage(imageb2, forState: .Normal)
//        button2.addTarget(self, action: "touchMyApp", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(button2)

        
        var button1 = UIButton()
        button1 = UIButton(frame: CGRectMake(20, 30, 60, 60))
        var imageb1 = UIImage(named: "Play.png") as UIImage!
        button1.center = CGPoint(x: centerP.x, y: centerP.y * 50/51 + 160)
        button1.setBackgroundImage(imageb1, forState: .Normal)
        button1.addTarget(self, action: "touchPlay", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button1)
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        
//        fff.center = CGPoint(x: centerP.x  * 8/6, y: centerP.y * 3/2)
        credit = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        credit?.text = "credit by abtranbn"
        
        credit?.textAlignment = NSTextAlignment.Center
        credit?.center = CGPoint(x: centerP.x , y: centerP.y * 2 - 50)
        credit?.font = UIFont (name: "Zapfino", size: 8)
        self.view.addSubview(credit!)
        

    }
    
    func touchPlay() {
        self.presentViewController(ViewController(), animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
//    var list = [SKProduct]()
//    var p = SKProduct()
//    
//    func buyProduct() {
//        println("buy " + p.productIdentifier)
//        var pay = SKPayment(product: p)
//        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
//        SKPaymentQueue.defaultQueue().addPayment(pay as SKPayment)
//    }
//    
//    func touchRemoveAds() {
//        
//        for product in list {
//            var prodID = product.productIdentifier
//            if(prodID == "com.mhtran.ImpossibleHurry") {
//                p = product
//                buyProduct()
////                splashPreferences.isSplashLoadingIndicatorEnabled = true
//                break;
//            }
//        }
//        
//    }
//    func touchMyApp() {
//        self.presentViewController(MyApp(), animated: true, completion: nil)
//    }
//    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
//        println("product request")
//        var myProduct = response.products
//        
//        for product in myProduct {
//            println("product added")
//            println(product.productIdentifier)
//            println(product.localizedTitle)
//            println(product.localizedDescription)
//            println(product.price)
//            
//            list.append(product as SKProduct)
//        }
//        
//        button0.enabled = true
//        button0.enabled = true
//    }
//    
//    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue!) {
//        println("transactions restored")
//        
//        var purchasedItemIDS = []
//        for transaction in queue.transactions {
//            var t: SKPaymentTransaction = transaction as SKPaymentTransaction
//            
//            let prodID = t.payment.productIdentifier as String
//            
//            switch prodID {
//            case "seemu.iap.removeads":
//                println("remove ads")
//                touchRemoveAds()
////            case "seemu.iap.addcoins":
////                println("add coins to account")
////                addCoins()
//            default:
//                println("IAP not setup")
//            }
//            
//        }
//    }
    
//    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
//        println("add paymnet")
//        
//        for transaction:AnyObject in transactions {
//            var trans = transaction as SKPaymentTransaction
//            println(trans.error)
//            
//            switch trans.transactionState {
//                
//            case .Purchased:
//                println("buy, ok unlock iap here")
//                println(p.productIdentifier)
//                
//                let prodID = p.productIdentifier as String
//                switch prodID {
//                case "seemu.iap.removeads":
//                    println("remove ads")
//                    touchRemoveAds()
////                case "seemu.iap.addcoins":
////                    println("add coins to account")
////                    addCoins()
//                default:
//                    println("IAP not setup")
//                }
//                
//                queue.finishTransaction(trans)
//                break;
//            case .Failed:
//                println("buy error")
//                queue.finishTransaction(trans)
//                break;
//            default:
//                println("default")
//                break;
//                
//            }
//        }
//    }
//    
//    func finishTransaction(trans:SKPaymentTransaction)
//    {
//        println("finish trans")
//    }
//    func paymentQueue(queue: SKPaymentQueue!, removedTransactions transactions: [AnyObject]!)
//    {
//        println("remove trans");
//    }
    



}
