//
//  AvatarCell.swift
//  MusicSearch
//
//  Created by Vinsi on 30/03/2022.
//
import UIKit

final class AvatarCell: UITableViewCell {

    @IBOutlet private(set) weak var albumImage: UIImageView!
}

struct AvatarModel: CellRepresentableModel {

    let image: String?

    func configure(cell: AvatarCell, index: IndexPath) {
        cell.albumImage?.imageUrl = image
    }
}
