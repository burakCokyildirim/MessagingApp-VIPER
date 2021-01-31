//
//  LetterCell.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 25.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class LetterCell: UICollectionViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var envelopeImage: UIImageView!
    @IBOutlet weak var stampImage: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setWidthConstraint(width: CGFloat) {
        widthConstraint.constant = width
    }
}
