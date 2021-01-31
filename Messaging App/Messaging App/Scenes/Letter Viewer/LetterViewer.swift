//
//  LetterViewer.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 3.05.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class LetterViewer: UIView {
    
    static var keyWindow: UIWindow? = {
         if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }()

    @IBOutlet var view: UIView!
    @IBOutlet weak var letterContent: UITextView!
    @IBOutlet weak var paperImage: UIImageView!
    @IBOutlet weak var letterContentConstraint: NSLayoutConstraint!
    @IBOutlet weak var blockUserButton: UIButton!
    @IBOutlet weak var reportUserButton: UIButton!
    
    var listener: LetterViewerListener?
    var letter: LetterModel!
    
    required init(letter: LetterModel) {
        if let keyWindow = LetterViewer.keyWindow {
            super.init(frame: keyWindow.frame)
        } else {
            super.init(frame: CGRect())
        }
        
        setupView()
        
        self.letter = letter
        self.letterContent.text = letter.content
        paperImage.image = UIImage(named: "paper\(letter.paperType.value)")
        
        if letter.paperType == .paperType6 {
            letterContentConstraint.isActive = true
        }
        
        if letter.incomingLetter {
            blockUserButton.isHidden = false
            reportUserButton.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        Bundle.main.loadNibNamed("LetterViewer", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func blockUserButtonTapped(_ sender: Any) {
        listener?.blockUser(userId: self.letter.fromUserId)
    }
    
    @IBAction func reportUserButtonTapped(_ sender: Any) {
        listener?.reportUser(letterId: self.letter.id)
    }
}

protocol LetterViewerListener {
    func blockUser(userId: String)
    func reportUser(letterId: String)
}
