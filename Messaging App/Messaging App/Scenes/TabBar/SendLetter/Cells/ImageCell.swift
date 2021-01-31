//
//  ImageCell.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 12.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    override var isSelected: Bool {
        didSet{
            self.image.alpha = isSelected ? 1.0 : 0.6
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
