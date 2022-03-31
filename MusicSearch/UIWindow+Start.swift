//
//  UIWindow+Helper.swift
//  MusicSearch
//
//  Created by Vinsi on 25/03/2022.
//

import UIKit

extension UIWindow {

    private func createNewRootViewController () -> UIViewController? {
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
        return navigationController
    }
    static func createWindow(using scene: UIScene) -> UIWindow {
        guard let windowScene = (scene as? UIWindowScene) else {
            fatalError("Window cannot init")
        }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        return window
    }
    static func createWindow() -> UIWindow {
        UIWindow(frame: UIScreen.main.bounds)
    }
    @discardableResult func setupForDisplay() -> UIWindow {
        rootViewController = createNewRootViewController()
        makeKeyAndVisible()
        return self
    }
}
