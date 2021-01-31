//
//  LetterCell2.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 29.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class LetterCell2: UICollectionViewCell {

    @IBOutlet weak var envelopeImage: UIImageView!
    @IBOutlet weak var stampImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setWidthConstraint(width: CGFloat) {
        widthConstraint.constant = width
    }
}
