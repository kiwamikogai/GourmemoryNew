//
//  ViewController4.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/05/31.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit
import CoreLocation

class Kiwami {
    
    var shopname: String!
    var image: UIImage!
    var coordinate: CLLocationCoordinate2D!
    var text: String!
    var category: String!
    var date: Date!
    var weekDay: String!

    init(shopname: String, image: UIImage, coordinate: CLLocationCoordinate2D,
         text: String, category: String, date: Date, weekDay: String
         ) {
        self.shopname = shopname
        self.image = image
        self.coordinate = coordinate
        self.text = text
        self.category = category
        self.date = date
        self.weekDay = weekDay
        
    }

}

class DataSave{
    
//    var kiwami: Kiwami!
    var array:[Kiwami] = []
    
    init(kiwami:Kiwami){
//        self.kiwami = kiwami
    }

    func save(newkiwami:Kiwami){
    var userDefault: UserDefaults = UserDefaults.standard
        array = userDefault.object(forKey: "kiwamiClass") as! [Kiwami]
        array.append(newkiwami)
        userDefault.set(array,forKey:"KiwamiClass")
}
}
