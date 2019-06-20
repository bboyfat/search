//
//  RatedCell.swift
//  TestSearch
//
//  Created by Andrey Petrovskiy on 6/20/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class RatedCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageVIew: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var routeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
