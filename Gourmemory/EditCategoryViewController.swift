//
//  EditCategoryViewController.swift
//  Gourmemory
//
//  Created by yuki takei on 2018/01/07.
//  Copyright © 2018年 Kiwami. All rights reserved.
//

import UIKit
import RealmSwift

class EditCategoryViewController: UIViewController {
    
    var category:Category?
    var getCategoryid = 0
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    var colorNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named:"Image-8")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(hex: "EFEFEF")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if category != nil {
            textField.text = category?.categoryName
            imageView.tintColor = UIColor(hex: (category?.colorCode)!)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedButton(sender:UIButton){
        colorNum = sender.tag
        var selectColor:String = colorCode(colorNum: colorNum)
        imageView.tintColor = UIColor(hex: selectColor)
    }
    
    @IBAction func tappedSaveButton(_ sender: Any) {
        
        let realm = RealmFactory.sharedInstance.realm()
        
        if category == nil {
            category = Category()
            category?.id = Category.findAll().count + 1
            category?.colorCode = colorCode(colorNum: colorNum)
            category?.categoryName = textField.text!
            category?.save()
        }else{
            try! realm.write {
                if colorNum != 0 {
                    category?.colorCode = colorCode(colorNum: colorNum)
                }
                category?.categoryName = textField.text!
            }
        }
        
        performSegue(withIdentifier: "toViewController2", sender: nil)
    }
    
    func colorCode(colorNum:Int) -> String{
        var code:String!
        
        switch colorNum {
        case 1:
            code = "FF6666"
        case 2:
            code = "FFE866"
        case 3:
            code = "66D6FF"
        case 4:
            code = "A866FF"
        case 5:
            code = "FF68AE"
        case 6:
            code = "4D63D1"
        case 7:
            code = "FFA528"
        case 8:
            code = "3F9FFF"
        case 9:
            code = "A866FF"
        default:
            code = "EFEFEF"
        }
        return code
    }
    
}

