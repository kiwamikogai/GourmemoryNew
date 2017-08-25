//
//  toViewController3.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/05/04.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit
import MapKit
import Accounts

class ViewController3: UIViewController{
    
    var kiwami: Kiwami?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var shopnameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    @IBAction func share(sender: UIButton) {
        
        // 共有する項目
        let shareText = "Apple - Apple Watch"
        let shareWebsite = NSURL(string: "https://www.apple.com/jp/watch/")!
        //let shareImage = UIImage(named: "shareSample.png")!
        let activityItems = [shareText, shareWebsite] as [Any]
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivityType.message,
            UIActivityType.saveToCameraRoll,
            UIActivityType.print
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x6AB9BE)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = kiwami!.weekDay
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        super.viewDidLoad()
        print(kiwami)
        guard let kiwami = kiwami else { return }
        //        dateLabel.text = kiwami.weekDay!
        imageView.image = UIImage(data: kiwami.imageData)
        shopnameLabel.text = kiwami.shopname
        categoryLabel.text = kiwami.category
        
        let center = CLLocationCoordinate2DMake(kiwami.latitude, kiwami.longitude)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        let rejion = MKCoordinateRegionMake(center, span)
        mapView.setRegion(rejion, animated:true)
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(kiwami.latitude, kiwami.longitude)
        mapView.addAnnotation(annotation)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


