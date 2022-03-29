//
//  AlbumSearchViewController.swift
//  MusicSearch
//
//  Created by Vinsi on 25/03/2022.
//

import UIKit
import Combine

fileprivate extension UISearchController {
    
    static func SearchController(
        delegate: UISearchResultsUpdating
    ) -> UISearchController {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = delegate
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }
}

final class AlbumSearchViewController: UITableViewController, StoryBoardInitializable {
    
    static var appStoryBoardIdentifier: UIStoryboard.Storyboard = .main
    lazy var loader: LoaderType = Loader(view: self.view)
    private let cancelBag = CancelBag()
    private(set) var viewModel: AlbumSearchViewModel? = AlbumSearchViewModel(searchRepo: SearchRepository())
    
    lazy var searchController = UISearchController.SearchController(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchUI()
        viewModel?.loader.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
            if $0 {
                self?.loader.show()
            } else {
                self?.loader.hide()
            }
            }).store(in: cancelBag)
        viewModel?.needReload
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            }).store(in: cancelBag)
    
    }
    
    private func setupSearchUI() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumListCell.identifier, for: indexPath)
        if let cell = cell as? AlbumListCell,
           let data = viewModel?.search(at: indexPath.row) {
            cell.configure(artist: data.artist,
                           streamable: data.streamable == "1",
                           name: data.name,
                           link: data.url,
                           image: data.image?.getImage(size: .medium)?.text)
        
        }
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            viewModel?.onMoreResult()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.searchCount ?? 0
    }

}

extension AlbumSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.keyword.send(searchController.searchBar.text ?? "")
    }
}

