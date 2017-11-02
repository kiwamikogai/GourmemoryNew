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
    
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var shopnameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    
    @IBAction func showAlert(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let action1 = UIAlertAction(title: "編集する", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("アクション１をタップした時の処理")
            
        })
        
        let action2 = UIAlertAction(title: "シェア", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("アクション２をタップした時の処理")
            
            // 共有する項目
            let shareText = "#グルメモリー"
            //            let shareWebsite = NSURL(string: "https://www.apple.com/jp/watch/")!
            let shareImage = self.imageView2.image!
            
            let activityItems: [Any] = [shareText, shareImage]
            
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
        })
        
        let action3 = UIAlertAction(title: "削除", style: UIAlertActionStyle.destructive, handler: {
            (action: UIAlertAction!) in
            print("アクション３をタップした時の処理")
            self.kiwami?.delete()
            self.navigationController?.popToRootViewController(animated: true)
        })
        
        
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        
        self.imageView2.layer.borderColor = UIColor(rgb: 0xC7E5E7).cgColor
        self.imageView2.layer.borderWidth = 7
        self.imageView2.layer.cornerRadius = 25
        self.imageView2.layer.masksToBounds = true
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x6AB9BE)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = kiwami!.weekDay
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        super.viewDidLoad()
        print("これは\(kiwami)")
        guard let kiwami = kiwami else { return }
       
        imageView2.image = UIImage(data: kiwami.imageData)
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


