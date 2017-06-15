//
//  ViewController4.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/06/08.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit

class BigCenterTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        setupBigCenterButton()
        
    }
    
    private func setupBigCenterButton(){
//        let button = UIButton(type: .custom)
        let button = UIButton()


        button.sizeToFit()
        button.center = CGPoint(x: tabBar.bounds.size.width / 2, y: tabBar.bounds.size.height - (button.bounds.size.height/2))
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(self.tapBigCenter(sender:)), for: .touchUpInside)
        tabBar.addSubview(button)
    }
    
    // タブ真ん中を選択する
    func tapBigCenter(sender:AnyObject) {
        selectedIndex = 2
        //prepare(for: "toViewControlller2", sender: nil)
        performSegue(withIdentifier: "toViewController2", sender: nil)
    
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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


