//
//  TableTableViewController.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/08/18.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit
import RealmSwift

class TableTableViewController: UITableViewController {
    
    var kiwamis: [Kiwami] = []
    var refresher: UIRefreshControl!
    var category:Results<Category>!
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x6AB9BE)
        
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
        refresher.attributedTitle = NSAttributedString(string: "更新する")
        refresher.tintColor = UIColor(rgb: 0x6AB9BE)
        refresher.addTarget(self, action: #selector(TableTableViewController.refresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        kiwamis = Kiwami.findAll()
        
        let realm = RealmFactory.sharedInstance.realm()
        category = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    func refresh() {
        kiwamis = Kiwami.findAll()
        let realm = RealmFactory.sharedInstance.realm()
        category = realm.objects(Category.self)
        tableView.reloadData()
        refresher.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ViewController3",sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewController3" {
            let vc3 = segue.destination as! ViewController3
            vc3.kiwami = kiwamis[sender as! Int]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kiwamis.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        //cell.storeLabel.text = kiwamis[indexPath.row].shopname
        cell.dateLabel.text = kiwamis[indexPath.row].weekDay
        cell.imageView2.image = UIImage(data: kiwamis[indexPath.row].imageData)

        var caregoryId = kiwamis[indexPath.row].categoryId
        let getCategory = category.filter("id == %@", "\(caregoryId)").first
        
        cell.categoryLabel.text = getCategory?.categoryName
        
        return cell
    }
    
    
}


