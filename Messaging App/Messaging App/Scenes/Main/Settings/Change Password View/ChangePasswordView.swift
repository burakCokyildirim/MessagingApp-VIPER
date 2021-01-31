//
//  ChangePasswordView.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 7.05.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

class ChangePasswordView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var oldPasswordText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    var delegate: ChangePasswordDelegate?
    
    required init(delegate: ChangePasswordDelegate) {
        if let keyWindow = LetterViewer.keyWindow {
            super.init(frame: keyWindow.frame)
        } else {
            super.init(frame: CGRect())
        }
        
        self.delegate = delegate
        
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        Bundle.main.loadNibNamed("ChangePasswordView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(press:)))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        oldPasswordText.becomeFirstResponder()
        
        oldPasswordText.delegate = self
        newPasswordText.delegate = self
        confirmPasswordText.delegate = self
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        oldPasswordText.text = ""
        newPasswordText.text = ""
        confirmPasswordText.text = ""
        self.removeFromSuperview()
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        if let oldPassword = oldPasswordText.text,
            let newPassword = newPasswordText.text,
            let confirmPassword = confirmPasswordText.text {
            delegate?.changeButtonTapped(oldPassword, newPassword, confirmPassword, self)
        }
    }
    
    @objc func dismissKeyboard(press: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
}

extension ChangePasswordView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case oldPasswordText:
            newPasswordText.becomeFirstResponder()
        case newPasswordText:
            confirmPasswordText.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

protocol ChangePasswordDelegate {
    func changeButtonTapped(_ oldPassword: String, _ newPassword: String, _ confirmPassword: String, _ view: UIView)
}
