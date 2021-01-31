//
//  LetterCell4.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.05.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

protocol RevertLetterAction {
    func revertLetter(letterID: Int)
}

class LetterCell4: UICollectionViewCell {

    @IBOutlet weak var dayCount: UILabel!
    @IBOutlet weak var hourCount: UILabel!
    @IBOutlet weak var minuteCount: UILabel!
    @IBOutlet weak var toUsername: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var letterID: String!
    var delegate: RevertLetterAction!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setWidthConstraint(width: CGFloat) {
        widthConstraint.constant = width
    }
    
    func setRemainingTime(deliveryTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let deliveryDate = dateFormatter.date(from: deliveryTime) else {
            return
        }
        
        let interval = deliveryDate - Date()
        guard
            let day = interval.day,
            let hour = interval.hour,
            let minute = interval.minute
            else { return }
        
        dayCount.text = String(format: "%02d", day)
        hourCount.text = String(format: "%02d", hour % 24)
        minuteCount.text = String(format: "%02d", minute % 60)
    }
    
    @IBAction func revertLetterButtonTapped(_ sender: Any) {
        if let leterID = Int(letterID) {
            delegate.revertLetter(letterID: leterID)
        }
    }
}
