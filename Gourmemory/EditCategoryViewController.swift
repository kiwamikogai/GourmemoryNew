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
        } else {
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
            code = "FDB8B9"
        case 2:
            code = "C470ED"
        case 3:
            code = "FC3A3F"
        case 4:
            code = "FEF034"
        case 5:
            code = "FD9E31"
        case 6:
            code = "44E178"
        case 7:
            code = "6CE5DC"
        case 8:
            code = "2AC0E9"
        case 9:
            code = "715DDF"
        default:
            code = "EFEFEF"
        }
        return code
    }
    
}

