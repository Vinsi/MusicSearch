//
//  SearchPaging.swift
//  MusicSearch
//
//  Created by Vinsi on 27/03/2022.
//
import Foundation

extension SearchResponseModel: PageContentType {
    var content: [Album] {
        self.results?.albumMatches?.album ?? []
    }
}

struct SearchPageRequest: PageRequestable {
    typealias ContentType = SearchResponseModel
    
    let keyword: String
    private let cancelBag = CancelBag()
    let repo: SearchRepositoryType
    private let logger = Logger()
    func page(no: Int,
              contentCount: Int,
              onCompletion: @escaping (Bool, SearchResponseModel?) -> ()) {
        repo.search(keyword: keyword, pageNo: no, limit: 20)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let err):
                    self.logger.log(type: .failure,
                                    err.errorDescription)
                case .finished:
                    break
                }
            }, receiveValue: { model in
               onCompletion(true, model)
            }).store(in: self.cancelBag)
    }
}
