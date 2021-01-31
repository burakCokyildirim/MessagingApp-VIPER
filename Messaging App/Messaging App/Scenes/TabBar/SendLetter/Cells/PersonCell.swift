//
//  PersonCell.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 19.04.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
