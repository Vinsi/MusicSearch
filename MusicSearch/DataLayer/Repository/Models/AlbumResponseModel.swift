//
//  AlbumResponseModel.swift
//  MusicSearch
//
//  Created by Vinsi on 27/03/2022.
//

// MARK: - AlbumResponseModel

struct AlbumResponseModel: Codable {

    let album: Album?
}

extension AlbumResponseModel {

    struct Album: Codable {

        let artist: String?
        let mbid: String?
        let tags: Tags?
        let playcount: String?
        let image: [Image]?
        let tracks: Tracks?
        let url: String?
        let name, listeners: String?
        let wiki: Wiki?
    }

    struct Image: Codable {

        let size: String?
        let text: String?

        enum CodingKeys: String, CodingKey {

            case size
            case text = "#text"
        }
    }

    struct Tags: Codable {

        let tag: [Tag]?
    }

    struct Tag: Codable {

        let url: String?
        let name: String?
    }

    struct Tracks: Codable {

        let track: [Track]?
    }

    struct Track: Codable {

        let streamable: Streamable?
        let duration: Int?
        let url: String?
        let name: String?
        let attr: Attr?
        let artist: Artist?

        enum CodingKeys: String, CodingKey {
            case streamable, duration, url, name
            case attr = "@attr"
            case artist
        }
    }

    struct Artist: Codable {

        let url: String?
        let name: String?
        let mbid: String?
    }

    // MARK: - Attr
    struct Attr: Codable {

        let rank: Int?
    }

    // MARK: - Streamable
    struct Streamable: Codable {

        let fulltrack, text: String?

        enum CodingKeys: String, CodingKey {
            case fulltrack
            case text = "#text"
        }
    }

    // MARK: - Wiki
    struct Wiki: Codable {

        let published, summary, content: String?
    }
}
