//
//  AlbumSearchViewModel.swift
//  MusicSearch
//
//  Created by Vinsi on 29/03/2022.
//

import Combine
import Foundation

final class AlbumSearchViewModel {

    private let searchRepo: SearchRepositoryType
    private let pageSize = 20
    private let debounceTimeInterval: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(200)
    let loader: CurrentValueSubject<Bool, Never> = .init(false)
    let needReload: PassthroughSubject<Bool, Never> = .init()
    let keyword: CurrentValueSubject<String, Never> = .init("")
    let logger = Logger(.search)
    let navigateToDetail: PassthroughSubject<(name: String?,
                                              artist: String?,
                                              mbid: String?), Never> = .init()
    private lazy var pagingManager: PagingManager<SearchPageRequest> =  PagingManager<SearchPageRequest>(pageRequest: .init(keyword: keyword.value,
                                                             repo: searchRepo),
                                                              firstPage: 1,
                                                            contentCount: pageSize)
    private let cancelBag = CancelBag()

    private func bindKeyword() {
        keyword
            .filter({
                Logger(.search).log("gota \($0)")
                return !$0.isEmpty
            })
            .debounce(for: debounceTimeInterval, scheduler: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.startSearch()
            }).store(in: cancelBag )
    }

    init(searchRepo: SearchRepositoryType) {
        self.searchRepo = searchRepo
        bindKeyword()
    }

    private func startSearch() {
        logger.log("started Search with:-\(keyword.value)")
        pagingManager = PagingManager<SearchPageRequest>(pageRequest: .init(keyword: keyword.value,
                                                               repo: searchRepo),
                                                         firstPage: 1,
                                                         contentCount: pageSize)
        search()

    }

    private func search() {
        loader.send(true)
        logger.log("page:-\(pagingManager.currentPageNo)")
        pagingManager.fetchNext { [weak self] _, _ in
            self?.loader.send(false)
            self?.needReload.send(true)
            self?.logger.log("searchComplete..")
        }
    }

    var searchCount: Int {
        pagingManager.contents.count
    }

    private func loadMore() {
        guard loader.value == false else {
            return
        }
        if pagingManager.isEndOfPage == false {
           logger.log("loadMoreStarted")
           search()
        }
    }

    func item(at index: Int) -> CellConfigurable {
        pagingManager.contents[index]
    }

    func onScroll(position: Double,
                  contentHeight: Double,
                  frameHeight: Double,
                  threshold: Double = 100) {
        if position > (contentHeight - threshold - frameHeight) && pagingManager.contents.count > 0 {
            loadMore()
        }
    }

    func onSelect(index: Int) {
        let content = pagingManager.contents[index]
        navigateToDetail.send((name: content.name, artist: content.artist, mbid: content.mbd))
    }

    func search(text: String?) {
        if let text = text,
           text != keyword.value {
            keyword.send(text)
        }
    }
}

extension SearchResponseModel.Album: AlbumListDataType {
    var album: String? {
        name
    }

    var mbd: String? {
        mbid
    }

    var thumbImage: String? {
        self.image?.getImage(size: .medium)?.text
    }

    var canStream: Bool {
        self.streamable == "1"
    }

    var link: String? {
        url
    }
}
