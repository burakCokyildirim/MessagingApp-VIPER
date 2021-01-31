//
//  Page0Cell.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 26.02.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class Page0Cell: UICollectionViewCell {
    
    @IBOutlet var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        
        Bundle.main.loadNibNamed("Page0Cell", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
}
