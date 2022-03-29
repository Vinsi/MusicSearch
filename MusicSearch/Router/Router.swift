//
//  Router.swift
//  MusicSearch
//
//  Created by Vinsi on 28/03/2022.
//

import UIKit
protocol Router: AnyObject {
    func present ( _ viewController: UIViewController, animated: Bool)
    func present (_ viewContromer: UIViewController, animated: Bool, onDismissed: (() -> Void)?)
    func dismiss (animated: Bool)
    func setRootViewController ( _ viewController: UIViewController)
    func setRootViewController(_ viewController: UIViewController, hideBar: Bool)
}
