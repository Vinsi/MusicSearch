//
//  AlbumDetailCoordinator.swift
//  MusicSearch
//
//  Created by Vinsi on 31/03/2022.
//
import UIKit
final class DetailCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []

    struct Parameter: SearchType {
        var album, mbd, artist: String?
    }
    var navigationController: UINavigationController
    let param: Parameter
    lazy private var viewController = DetailViewController.newInstance()

    init(navigationController: UINavigationController, param: Parameter) {
        self.navigationController = navigationController
        self.param = param
    }

    func start() {
        viewController.viewModel.search = param
        navigationController.pushViewController(viewController, animated: true)
    }
}
