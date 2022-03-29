//
//  Segue+Helper.swift
//  WeatherViper
//
//  Created by Vinsi on 22/12/2021.
//

import UIKit

protocol SegueIdentifiable {

    var identifier: String { get }
}

extension SegueIdentifiable where Self: RawRepresentable, Self.RawValue == String {
    var identifier: String {
        return rawValue
    }
}

extension UIViewController {

    func performSegue(segue: SegueIdentifiable, sender: Any?) {
        performSegue(withIdentifier: segue.identifier, sender: sender)
    }
}
