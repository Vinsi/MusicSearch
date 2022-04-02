//
//  URL+Params.swift
//  MusicSearch
//
//  Created by Vinsi on 01/04/2022.
//

import Foundation
extension URL {
    var params: [String: String]? {
        URLComponents(url: self, resolvingAgainstBaseURL: true)?
            .queryItems?.reduce([String: String]()) {
                var prev = $0
                prev[$1.name] = $1.value
                return prev
            }
    }
}
