//
//  AlbumListCell.swift
//  MusicSearch
//
//  Created by Vinsi on 29/03/2022.
//

import UIKit
import Kingfisher

final class AlbumListCell: UITableViewCell {
    
    @IBOutlet private weak var artistLabel, streamableLabel, nameLabel: UILabel!
    @IBOutlet private weak var thumbNailImageView: LoaderImageView!
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var openLinkButton: UIButton!
    private var link: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.applyBorder()
    }
    
    func configure(artist: String?,
                   streamable: Bool,
                   name: String?,
                   link: String?,
                   image: String?) {
        
        artistLabel.text = artist
        streamableLabel.isHidden = !streamable
        nameLabel.text = name
        thumbNailImageView.applyBorder()
        thumbNailImageView.imageUrl = image
        self.link = link
        if let _ = link {
            openLinkButton.isHidden = false
        } else  {
            openLinkButton.isHidden = true
        }
        
    }
    
    @IBAction func onTapLink() {
        if let link = self.link ,
           let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}
