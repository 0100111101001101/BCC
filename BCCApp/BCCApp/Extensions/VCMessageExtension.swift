//
//  VCMessageExtension.swift
//  BCCApp
//
//  Created by Om Mandavia on 10/6/2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    /*
         This is a extension method for all View Controllers to be able to show an Alert in a easy format.
     
         Parameters:
             title: String - This is the title of the alert box
             message: String - This is the message of the alert box
     */
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
