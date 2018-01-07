//
//  CategorySettingViewCell.swift
//  Gourmemory
//
//  Created by yuki takei on 2018/01/07.
//  Copyright © 2018年 Kiwami. All rights reserved.
//

import UIKit

class CategorySettingViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
