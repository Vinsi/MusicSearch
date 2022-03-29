//
//  Paging.swift
//  MusicSearch
//
//  Created by Vinsi on 27/03/2022.
//

protocol PageRequestable {
    associatedtype ContentType: PageContentType
    func page(no: Int, contentCount: Int, onCompletion: @escaping (_ isSuccess: Bool,_ result: ContentType?) -> ())
}

protocol PageContentType {
    associatedtype PageElement
    var content: [PageElement] { get }
}

protocol PageManagable: AnyObject {
    associatedtype ContentType: PageContentType
    var contents: [ContentType.PageElement] { get }
    var isEndOfPage: Bool { get }
    var pageSize: Int { get }
    var currentPageNo: Int { get }
    func startFromBeginning()
    func fetchNext(onCompletion: @escaping(_ isSuccess: Bool, _ result: ContentType?) -> ())
}

extension PageManagable {
    var hasMorePages: Bool {
        return isEndOfPage == false
    }
}

final class PagingManager<PageRequestType: PageRequestable>: PageManagable {

    typealias ContentType = PageRequestType.ContentType
    var lastResponse: PageRequestType.ContentType?
    var contents: [PageRequestType.ContentType.PageElement]
    var pageRequest: PageRequestType
    private(set)var isEndOfPage: Bool = false
    private(set)var pageSize: Int
    private(set)var currentPageNo: Int
    private let firstPage: Int
    private let lastPage: Int?
    
    init(pageRequest: PageRequestType, firstPage: Int = 0 , contentCount: Int, lastPage: Int? = nil) {
        self.currentPageNo = firstPage
        self.firstPage = firstPage
        self.pageRequest = pageRequest
        self.pageSize = contentCount
        self.lastPage = lastPage
        self.contents = []
    }
    
    func startFromBeginning() {
        isEndOfPage = false
        currentPageNo = firstPage
        contents = []
    }
    
    func fetchNext(onCompletion: @escaping (_ success: Bool, _ data: PageRequestType.ContentType?) -> ()) {
        
        if !isEndOfPage, let lastPage = lastPage {
          isEndOfPage = currentPageNo > lastPage
        }
        
        guard !isEndOfPage else {
            onCompletion(false, nil)
            return
        }
        
        fetch { [weak self](success, result) in
            guard let self = self else {
                onCompletion(false, nil)
                return
            }
            if success, let result = result {
                self.lastResponse = result
                self.isEndOfPage = self.checkIsEndOfPage(lastReponse: self.lastResponse, resultCount: result.content.count , pageSize: self.pageSize)
                self.contents.append(contentsOf: result.content)
                self.currentPageNo += 1
                onCompletion(success, result)
            }
        }
    }
   
    private func fetch( onCompletion: @escaping (_ isSuccess: Bool,_ result:ContentType?) -> ()) {
        guard isEndOfPage == false else {
            onCompletion(false, nil )
             return
        }
        pageRequest.page(no: currentPageNo, contentCount: pageSize) { success, result in
            guard let result = result else {
                onCompletion(false, nil)
                return
            }
            onCompletion(success, result)
        }
    }

    func checkIsEndOfPage(lastReponse: PageRequestType.ContentType?, resultCount: Int, pageSize: Int ) -> Bool {
        //MARK:- This function overridable in case need to change the endOfPage Logic
       return  resultCount < pageSize
    }
}
