//
//  toViewController3.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/05/04.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit
import MapKit

class ViewController3: UIViewController{
    
    var kiwami: Kiwami?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var shopnameLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x6AB9BE)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.title = kiwami!.weekDay
        
        super.viewDidLoad()
        print(kiwami)
        guard let kiwami = kiwami else { return }
//        dateLabel.text = kiwami.weekDay!
        imageView.image = UIImage(data: kiwami.imageData)
        shopnameLabel.text = kiwami.shopname
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
