//
//  UIimageView+Helper.swift
//  MusicSearch
//
//  Created by Vinsi on 29/03/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    var imageUrl: String? {
        set {
            guard let value = newValue,
                let url = URL(string: value) else {
                return
            }
            kf.setImage(with: url)
        }
        get {
            nil
        }
    }
    
}
