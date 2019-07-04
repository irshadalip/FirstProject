//
//  TableViewCell.swift
//  Firebase_Instagram
//
//  Created by Irshadali Palsaniya on 01/07/19.
//  Copyright © 2019 Irshadali Palsaniya. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ImageOfCell: UIImageView!
    @IBOutlet weak var postLabelOut: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
