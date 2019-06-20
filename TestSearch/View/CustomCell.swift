//
//  CustomCell.swift
//  TestSearch
//
//  Created by Andrey Petrovskiy on 6/20/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

let identifier = "customCell"

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageVIew: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var routeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageVIew.layer.borderColor = UIColor.black.cgColor
        avatarImageVIew.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
