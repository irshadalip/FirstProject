//
//  RoundCollectionViewCell.swift
//  Firebase_Instagram
//
//  Created by Irshadali Palsaniya on 04/07/19.
//  Copyright © 2019 Irshadali Palsaniya. All rights reserved.
//

import UIKit

class RoundCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var buttonView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
         buttonView.layer.cornerRadius = buttonView.frame.size.height/2
    }
    
}
