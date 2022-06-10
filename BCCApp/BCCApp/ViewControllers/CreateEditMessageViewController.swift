//
//  CreateEditMessageViewController.swift
//  BCCApp
//
//  Created by Om Mandavia on 10/6/2022.
//

import UIKit

class CreateEditMessageViewController: UIViewController {
    
    // Declaring optional variables to allow mutation in navigation methods
    var message: String?
    weak var saveMessageDelegate: CreateEditMessageDelegate?
    
    
    let messageTextView = UITextView()
    var isEdit = false


    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addConstraints()
        
        messageTextView.textAlignment = .justified
        if let message = message {
            messageTextView.text = message
            isEdit = true                                   // determining whether the vc will be in edit mode or add mode
        } else {
            self.navigationItem.title = "Add Message"
            isEdit = false
        }
    }
    
    // MARK: - Actions
    
    @IBAction func saveMessage(_ sender: Any) {
        
        if let newMessage = messageTextView.text, !newMessage.isEmpty {
            saveMessageDelegate?.updateData(messageTextView.text, isEdit: isEdit)   // Validating & sending the data back
            self.navigationController?.popViewController(animated: true)
        } else {
            displayMessage(title: "Attention", message: "A message cannot be empty.")
            return                                                                  // notifying user about the issue
        }
    }
    
    // MARK: - AutoLayout methods
    
    // This function adds constraints to the text label programmatically
    func addConstraints(){
        view.addSubview(messageTextView)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding contraints of 16 points on all four sides with respect to the view
        messageTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        messageTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        messageTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
}
