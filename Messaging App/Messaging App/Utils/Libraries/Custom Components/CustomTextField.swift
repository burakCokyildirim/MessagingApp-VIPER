//
//  CustomTextField.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 8.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

@IBDesignable open class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
    
    // Provides left padding for images
    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += leftPadding
        return leftViewRect
    }

    // Provides right padding for images
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect.inset(by: padding)
    }
    
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var clearButtonRect = super.clearButtonRect(forBounds: bounds)
        clearButtonRect.origin.x -= clearButtonPadding
        return clearButtonRect
    }
    
    @IBInspectable open var leftButton : Bool = false {
        didSet {
            updateView()
        }
    }

    @IBInspectable open var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable open var clearButtonPadding: CGFloat = 0
    
    @IBInspectable open var leftPadding: CGFloat = 0
    
    @IBInspectable open var rightPadding: CGFloat = 0
    
    var leftViewButton: UIButton!

    private func updateView() {
        
        if let image = leftImage {
            
            if !leftButton {
                leftViewMode = UITextField.ViewMode.always
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                imageView.frame.size.height *= 0.7
    
                let iconContainerView: UIView = UIView(frame: imageView.bounds)
                iconContainerView.addSubview(imageView)
                leftView = iconContainerView
            } else {
                leftViewMode = UITextField.ViewMode.always
                leftViewButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                leftViewButton.setImage(image, for: .normal)
                leftViewButton.contentMode = .scaleAspectFit
                
                let iconContainerView: UIView = UIView(frame: leftViewButton.frame)
                iconContainerView.addSubview(leftViewButton)
                leftView = iconContainerView
            }
            
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
}
