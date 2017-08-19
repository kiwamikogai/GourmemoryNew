//
//  TableTableViewController.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/08/18.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    var kiwamis: [Kiwami] = []
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        kiwamis = Kiwami.findAll()
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.tintColor = UIColor(red:1.00,green:0.21,blue:0.55,alpha:1.0)
        refresher.addTarget(self, action: #selector(TableTableViewController.refresh), for: .valueChanged)
    }
    
    func refresh() {
        kiwamis = Kiwami.findAll()
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
        print(indexPath)
        performSegue(withIdentifier: "ViewController4",sender: nil)
    }
    
    
    
    // tableviewセルの個数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kiwamis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.storeLabel.text = kiwamis[indexPath.row].shopname
        cell.dateLabel.text = kiwamis[indexPath.row].weekDay
        cell.categoryLabel.text = kiwamis[indexPath.row].category
        cell.placeLabel.text = kiwamis[indexPath.row].text
        return cell
    }
    
    
}

 
