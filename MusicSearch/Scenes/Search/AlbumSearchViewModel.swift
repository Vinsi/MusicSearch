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
    let loader: CurrentValueSubject<Bool,Never> = .init(false)
    let needReload: PassthroughSubject<Bool,Never> = .init()
    let keyword: CurrentValueSubject<String,Never> = .init("")
    private var pagingManager: PagingManager<SearchPageRequest>?
    private let cancelBag = CancelBag()
    
    private func bindKeyword() {
        keyword
            .filter({ !$0.isEmpty
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
        pagingManager = PagingManager<SearchPageRequest>(pageRequest: .init(keyword: keyword.value,
                                                               repo: searchRepo),
                                                         firstPage: 1,
                                                         contentCount: pageSize)
        search()
     
    }
    
    private func search() {
        loader.send(true)
        pagingManager?.fetchNext { [weak self] success, data in
            self?.loader.send(false)
            self?.needReload.send(true)
        }
    }
    
    var searchCount: Int {
        pagingManager?.contents.count ?? 0
    }
    
    func onMoreResult() {
        guard loader.value == false else {
            return
        }
        if pagingManager?.isEndOfPage == false {
           search()
        }
    }
    
    func search(at index: Int) -> PagingManager<SearchPageRequest>.ContentType.Album? {
        pagingManager?.contents[index]
    }
}
