//
//  AllMessagesTableViewController.swift
//  BCCApp
//
//  Created by Om Mandavia on 10/6/2022.
//

import UIKit

class AllMessagesTableViewController: UITableViewController, CreateEditMessageDelegate {
    
    let EDIT_MESSAGE_SEGUE = "editMessageSegue"
    let MESSAGE_COUNT_CELL = "messageCountCell"
    let NO_OF_SECTIONS = 2                                      // Initialising all the constants
    let ALL_MESSAGES_SECTION = 0
    let MESSAGE_COUNT_SECTION = 1
    let APP_GROUP_NAME = "group.com.om.mandavia.bcc"
    
    var lastSelectedRowIndex = 0
    var isEditSegue = false                             // To differentiate edit/add functionality
    
    var allMessages = [String]()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registering a custom table view cell
        self.tableView.register(MessageCountTableViewCell.self, forCellReuseIdentifier: MESSAGE_COUNT_CELL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Updating the object data to make sure that it is up-to-date
        allMessages = UserDefaults(suiteName: APP_GROUP_NAME)?.stringArray(forKey: "allMessages") ?? [String]()
        tableView.reloadData()
    }
    
    // MARK: - 
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return NO_OF_SECTIONS
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case ALL_MESSAGES_SECTION:
                return UITableView.automaticDimension
            default:                                                // setting row heights based on section type
                return 80.0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case ALL_MESSAGES_SECTION:
                return allMessages.count
            default:
                return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == ALL_MESSAGES_SECTION {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            var content = cell.defaultContentConfiguration()
            content.text = allMessages[indexPath.row]                                   // Using default cell for messages
            cell.contentConfiguration = content
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        } else {
            
            // Using custom cell to display total message count information
            let infoCell = tableView.dequeueReusableCell(withIdentifier: MESSAGE_COUNT_CELL, for: indexPath) as! MessageCountTableViewCell
        
            if allMessages.isEmpty {
                infoCell.infoTextLabel.text = "No preset messages.\nTap + to add a message"
            } else {
                let infoText = "\(allMessages.count) saved message"
                let infoExtension = allMessages.count > 1 ? "s" : ""
                infoCell.infoTextLabel.text = infoText + infoExtension
            }
            infoCell.selectionStyle = .none
            return infoCell
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
            case ALL_MESSAGES_SECTION:
                return true
            default:
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete && indexPath.section == ALL_MESSAGES_SECTION {
            let alert = UIAlertController(title: "Caution", message: "This action cannot be undone", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                
                // deleting the data persistently & updating the table view
                self.tableView.performBatchUpdates({
                    self.allMessages.remove(at: indexPath.row)
                    UserDefaults(suiteName: self.APP_GROUP_NAME)?.set(self.allMessages, forKey: "allMessages")
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.reloadSections([self.MESSAGE_COUNT_SECTION], with: .automatic)
                    }, completion: nil)
        
            }))
            
            self.present(alert, animated: true, completion: nil)        // Confirming a persistent action
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == ALL_MESSAGES_SECTION {
            lastSelectedRowIndex = indexPath.row                                    // edit mode functionality
            isEditSegue = true
            performSegue(withIdentifier: EDIT_MESSAGE_SEGUE, sender: self)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addMessage(_ sender: Any) {
        performSegue(withIdentifier: EDIT_MESSAGE_SEGUE, sender: self)      // add message functionality
    }
    
    // MARK: - CreateEditMessageDelegate methods

    func updateData(_ newMessage: String, isEdit: Bool) {
        if isEdit {
            self.allMessages[lastSelectedRowIndex] = newMessage
        } else {
            self.allMessages.append(newMessage)                                 // updating the object data based on flag value
        }
        UserDefaults(suiteName: APP_GROUP_NAME)?.set(self.allMessages, forKey: "allMessages")      // persisting the changes
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == EDIT_MESSAGE_SEGUE {
            let destinationViewController = segue.destination as! CreateEditMessageViewController
            destinationViewController.saveMessageDelegate = self        // setting up the delegate in destination vc
            if isEditSegue {
                destinationViewController.message = allMessages[lastSelectedRowIndex]   // setting up the message in destination vc
                isEditSegue = false                                     // resetting the flag
            }
        }
    }
}
