//
//  SplashViewController.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 1.03.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import UIKit

class SplashViewController: BaseViewController {
    
    // MARK: - Outlets
    
    // MARK: - Dependencies
    
    var presenter: SplashPresenterViewProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            if UserDefaults.standard.bool(forKey: "hasRunBefore") {
                LoginWireframe().show(transitionType: .root)
            } else {
                OnboardingWireframe().show(transitionType: .root)
            }
        }
    }
    
    // MARK: - Configure
    
    override func configureView() {
        super.configureView()
        
    }
    
    // MARK: - Initialization
    
    // MARK: - Actions
    
}

// MARK: - Extensions

// MARK: - Protocol Implemantations

extension SplashViewController: SplashViewControllerProtocol {
    
}
