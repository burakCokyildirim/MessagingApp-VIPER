//
//  CircleCell.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 12.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class CircleCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var hourCountLabel: UILabel!
    @IBOutlet weak var minuteCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(_ day: String, _ hour: String, _ minute: String) {
        dayCountLabel.text = day
        hourCountLabel.text = hour
        minuteCountLabel.text = minute
    }
}
