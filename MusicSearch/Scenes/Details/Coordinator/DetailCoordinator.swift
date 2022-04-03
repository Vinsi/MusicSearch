//
//  AlbumDetailCoordinator.swift
//  MusicSearch
//
//  Created by Vinsi on 31/03/2022.
//
import UIKit

struct DetailParameter: SearchType {
    var album, mbID, artist: String?
}

final class DetailCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let param: SearchType
    lazy private var viewController = DetailViewController.newInstance()

    init(navigationController: UINavigationController, param: SearchType) {
        self.navigationController = navigationController
        self.param = param
    }

    func start() {
        viewController.viewModel.search = param
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
