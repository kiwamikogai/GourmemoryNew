//
//  CategorySettingViewController.swift
//  Gourmemory
//
//  Created by yuki takei on 2018/01/07.
//  Copyright © 2018年 Kiwami. All rights reserved.
//

import UIKit
import RealmSwift

//カテゴリー編集のためのクラス、tableView
class CategorySettingViewController: UITableViewController {
    

    var categoryData:Results<Category>? //カテゴリーの中身
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        readCategoryData()
        tableView.reloadData()
        
    }
    
    //realmのカテゴリーを読み込む
    
    func readCategoryData(){
        
        let realm = RealmFactory.sharedInstance.realm()
        if realm.objects(Category.self) != nil {
            categoryData = realm.objects(Category.self)
            
        }
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toEditCategory", sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender != nil {
            var indexPath = sender as! IndexPath
            let editCategoryVC = segue.destination as! EditCategoryViewController
            editCategoryVC.category = categoryData![indexPath.row] as!Category
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //rowの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //categoryDataの中身の数に応じてcellを作る
        if categoryData != nil {
            return categoryData!.count
        }
        //なければ何も表示しない
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category:Category = categoryData![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategorySettingViewCell
        
        cell.categoryImageView.image = UIImage(named:"Image-8")?.withRenderingMode(.alwaysTemplate)
        cell.categoryImageView.tintColor = UIColor(hex: category.colorCode)
        cell.categoryNameLabel.text = category.categoryName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toEditCategory", sender: indexPath)
    }
    
    
}

