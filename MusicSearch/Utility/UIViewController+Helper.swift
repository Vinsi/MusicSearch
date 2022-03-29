//
//  UIViewController+Helper.swift
//  DailyRail
//
//  Created by Vinsi on 27/12/2021.
//

import UIKit

extension UIViewController {
    
    func embeddedInNavigationController() -> Self {
        Self.embedInNavigationController(vwc: self)
    }
    
    static func embedInNavigationController<T:UIViewController>(vwc view: T) -> T {
        let navController = UINavigationController(rootViewController: view)
        navController.modalPresentationStyle = .fullScreen
        return view
    }
}


