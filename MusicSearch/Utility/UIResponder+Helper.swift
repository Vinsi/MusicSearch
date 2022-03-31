//
//  UIResponder+Helper.swift
//  MusicSearch
//
//  Created by Vinsi on 30/03/2022.
//

import UIKit

protocol UIIdentifiable {}

extension UIIdentifiable {

    static var identifier: String {
        return "\(self)"
    }
}

extension UIResponder: UIIdentifiable {}
