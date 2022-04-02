//
//  MainCoordinator.swift
//  MusicSearch
//
//  Created by Vinsi on 31/03/2022.
//
import UIKit

final class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var children: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let albumSearch = AlbumSearchViewController.newInstance()
        albumSearch.parentCoordinator = self
        navigationController.delegate = self
        navigationController.pushViewController(albumSearch, animated: false)
    }

    func showDetail(name: String?, artist: String?, mbid: String?) {
        let childCoordinator = DetailCoordinator(navigationController: navigationController,
                                                 param: DetailParameter(album: name,
                                                                        mbID: mbid,
                                                                        artist: artist)
        )
        children.append(childCoordinator)
        childCoordinator.start()
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller,
        // so we can check whether it’s a buy view controller
        if let detailVwc = fromViewController as? DetailViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(detailVwc.coordinator)
        }
    }
}
