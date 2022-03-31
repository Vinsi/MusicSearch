//
//  Coordinator.swift
//  MusicSearch
//
//  Created by Vinsi on 28/03/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in children.enumerated() where coordinator === child {
                children.remove(at: index)
                break
        }
    }
}
