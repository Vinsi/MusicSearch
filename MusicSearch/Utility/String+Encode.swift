//
//  String+Encode.swift
//  MusicSearch
//
//  Created by Vinsi on 30/03/2022.
//

extension String {
    var encoded: String? { addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)}
}
