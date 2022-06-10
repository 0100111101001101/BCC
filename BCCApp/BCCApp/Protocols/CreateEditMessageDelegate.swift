//
//  CreateEditMessageDelegate.swift
//  BCCApp
//
//  Created by Om Mandavia on 10/6/2022.
//

import Foundation

protocol CreateEditMessageDelegate: AnyObject {
    func updateData(_ newMessage: String, isEdit: Bool)         // A protocol to save or update data persistently
}

