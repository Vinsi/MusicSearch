//
//  SceneDelegate.swift
//  MusicSearch
//
//  Created by Vinsi on 25/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow.createWindow(using: scene).setupForDisplay()
    }
}
