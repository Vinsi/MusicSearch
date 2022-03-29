//
//  Combine+Helper.swift
//  WeatherViper
//
//  Created by Vinsi on 23/12/2021.
//

import Combine

final class CancelBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {

    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
