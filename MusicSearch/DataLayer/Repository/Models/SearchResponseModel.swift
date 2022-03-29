//
//  SearchResponseModel.swift
//  MusicSearch
//
//  Created by Vinsi on 27/03/2022.
//

// MARK: - SearchResponseModel

struct SearchResponseModel: Codable {
    
    let results: Results?
}

extension SearchResponseModel {
    
    struct Results: Codable {
        
        let opensearchQuery: OpenSearchQuery?
        let opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String?
        let albumMatches: AlbumMatches?
        let attr: Attr?
        
        enum CodingKeys: String, CodingKey {
            case opensearchQuery = "opensearch:Query"
            case opensearchTotalResults = "opensearch:totalResults"
            case opensearchStartIndex = "opensearch:startIndex"
            case opensearchItemsPerPage = "opensearch:itemsPerPage"
            case albumMatches = "albummatches"
            case attr = "@attr"
        }
    }

    struct AlbumMatches: Codable {
        let album: [Album]?
    }
    
    struct Album: Codable {
        let name, artist: String?
        let url: String?
        let image: [Image]?
        let streamable, mbid: String?
    }
    
    struct Image: Codable {
        let text: String?
        let size: Size?
        
        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case size
        }
    }
    
    enum Size: String, Codable {
        case extralarge = "extralarge"
        case large = "large"
        case medium = "medium"
        case small = "small"
    }
    
    struct Attr: Codable {
        let attrFor: String?
        
        enum CodingKeys: String, CodingKey {
            case attrFor = "for"
        }
    }
    
    struct OpenSearchQuery: Codable {
        let text, role, searchTerms, startPage: String?
        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case role, searchTerms, startPage
        }
    }
}

extension Array where Element == SearchResponseModel.Image {
    
    func getImage(size: SearchResponseModel.Size) -> SearchResponseModel.Image? {
        first { $0.size == size }
    }
}
