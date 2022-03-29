//
//  Coordinator.swift
//  MusicSearch
//
//  Created by Vinsi on 28/03/2022.
//

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: Router { get }
    func present(animated: Bool, onDismissed: ( () -> Void)?)
    func dismiss(animated: Bool)
    func presentChild(_ child: Coordinator,
                      animated: Bool,
                      onDismissed: (()-> Void)?)
}
