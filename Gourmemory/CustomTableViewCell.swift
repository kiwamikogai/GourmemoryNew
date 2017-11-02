//
//  CustomTableViewCell.swift
//  Gourmemory
//
//  Created by Kiwami on 2017/08/18.
//  Copyright © 2017年 Kiwami. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var storeLabel: UILabel!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
