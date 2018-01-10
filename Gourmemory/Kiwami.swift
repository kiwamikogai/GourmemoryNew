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
    
    dynamic var id = 0
    dynamic var shopname: String!
    dynamic var imageData: Data!
    
    dynamic var latitude: Double = 37.331652997806785
    dynamic var longitude: Double = -122.03072304117417
    
    dynamic var text: String!
    dynamic var category: String!
    dynamic var date: Date!
    dynamic var weekDay: String!
    
    static func findAll() -> [Kiwami] {
        let realm = RealmFactory.sharedInstance.realm()
        let kiwamis = realm.objects(Kiwami.self)
        return kiwamis.map { $0 }.reversed()
    }
    
    // realm削除
    func delete() {
        let realm = RealmFactory.sharedInstance.realm()
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch let error  {
            print(error)
        }
        
    }
    
    //idをプライマリキーに設定
    override static func primaryKey() -> String?{
        return "id"
    }
    
    func save(){
        let realm = RealmFactory.sharedInstance.realm()
        do{
            try realm.write {
                realm.add(self)
            }
        }catch let error as NSError{
            print(error)
        }
    }
}

class Category: Object {
    
    dynamic var id:Int = 0
    dynamic var categoryName:String!
    dynamic var colorCode:String!
}
//画像リサイズ用
extension UIImage{
    func resize(image: UIImage, width: Int, height: Int) -> UIImage {
        let size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x:0, y:0, width:size.width, height:size.height))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage!
    }
    
}
