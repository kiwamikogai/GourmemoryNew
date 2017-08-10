//
//  ViewController4.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/05/31.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift


class Kiwami: Object {
    
    dynamic var shopname: String!
//    var image: UIImage!
    dynamic var imageData: Data!
//    var coordinate: CLLocationCoordinate2D!
    
    dynamic var latitude: Double = 37.331652997806785
    dynamic var longitude: Double = -122.03072304117417
    
    dynamic var text: String!
    dynamic var category: String!
    dynamic var date: Date!
    dynamic var weekDay: String!

//    init(shopname: String, image: UIImage, coordinate: CLLocationCoordinate2D,
//         text: String, category: String, date: Date, weekDay: String
//         ) {
//        self.shopname = shopname
//        self.image = image
//        self.coordinate = coordinate
//        self.text = text
//        self.category = category
//        self.date = date
//        self.weekDay = weekDay
//        
//    }

}


//画像リサイズ用
extension UIImage{
    func resize(image: UIImage, width: Int, height: Int) -> UIImage {
        let imageRef: CGImage = image.cgImage!
        var sourceWidth: Int = imageRef.width
        var sourceHeight: Int = imageRef.height
        
        var size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x:0, y:0, width:size.width, height:size.height))
        
        var resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage!
    }

}


//ここはUserDefaultsで保存するときのみ使用
//今回はRealmを使うから要らないかな
class DataSave{
    
    //    var kiwami: Kiwami!
    var array:[Kiwami] = []
    
    init(){
        //        self.kiwami = kiwami
    }

    func save(newkiwami:Kiwami){
        print(newkiwami)
        let userDefault: UserDefaults = UserDefaults.standard
        
        if userDefault.object(forKey: "iwaKmiClass") != nil{
            array = userDefault.object(forKey: "KiwamiClass") as! [Kiwami]
        }
        
        array.append(newkiwami)
        userDefault.set(array, forKey:"KiwamiClass")
    }
}
