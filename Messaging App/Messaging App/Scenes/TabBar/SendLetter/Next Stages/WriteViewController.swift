//
//  WriteViewController.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 16.04.2020.
//  Copyright (c) 2020 Softbea. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import UIKit

class WriteViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var letterContent: UITextView!
    @IBOutlet weak var paperImage: UIImageView!
    
    // MARK: - Dependencies
    
    var presenter: SendLetterPresenterViewProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let paperType = presenter.paperType?.value {
            paperImage.image = UIImage(named: "paper\(paperType)")
        }
    }
    
    // MARK: - Configure
    
    override func configureView() {
        super.configureView()
        
        barTitle = "put_your_mind_on_paper".localized
        letterContent.delegate = self
    }
    
    // MARK: - Initialization
    
    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.leftTapped()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        presenter.setContentAndNext(content: letterContent.text)
    }
}

// MARK: - Extensions

extension WriteViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == letterContent {
            textView.text = textView.text?.censored()
        }
    }
}

// MARK: - Protocol Implemantations

extension WriteViewController: WriteViewControllerProtocol {
    
    func complateWriting() {
        let nextController: PersonSelectionViewController = UIStoryboard.sendLetter.instantiateViewController()
        presenter.personSelectViewController = nextController
        nextController.presenter = presenter
               
        navigationController?.pushViewController(nextController, animated: false)
    }
}
