//
//  AppDelegate.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/02/02.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let color = UIColor(rgb: 0xC7E5E7)
        
        //ナビゲーションアイテムの色を変更
        UINavigationBar.appearance().tintColor = UIColor.red
        //ナビゲーションバーの背景を変更
        UINavigationBar.appearance().barTintColor = color
        //ナビゲーションのタイトル文字列の色を変更
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.green]
        
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    class ViewController: UIViewController {
        
        @IBOutlet weak var testMapView: MKMapView!
        
        //最初からあるメソッド
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //中心座標
            let center = CLLocationCoordinate2DMake(35.690553, 139.699579)
            
            //表示範囲
            let span = MKCoordinateSpanMake(0.001, 0.001)
            
            //中心座標と表示範囲をマップに登録する。
            let region = MKCoordinateRegionMake(center, span)
            testMapView.setRegion(region, animated:true)
            
            //地図にピンを立てる。
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(35.690553, 139.699579)
            testMapView.addAnnotation(annotation)
            
        }
    }
    
    
}

