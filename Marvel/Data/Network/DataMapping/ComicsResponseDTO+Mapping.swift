//
//  ComicsResponseDTO+Mapping.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation

// MARK: - ComicsResponseDTO
struct ComicsResponseDTO: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let comics: [ComicResponseDTO]
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case comics = "results"
    }
}

// MARK: - ComicResponseDTO
struct ComicResponseDTO: Codable {
    let id: Int
    let digitalID: Int?
    let title: String?
    let issueNumber: Int?
    let variantDescription: String?
    let description: String?
    let isbn, upc: String?
    let ean, issn: String?
    let pageCount: Int?
    let resourceURI: String?
    let urls: [URLElement]?
    let series: SeriesDTO?
    let variants: [SeriesDTO]?
    let collectedIssues: [SeriesDTO]?
    let dates: [DateElement]?
    let thumbnail: Thumbnail?
    let images: [Thumbnail]?
    let creators: CreatorsDTO?
    let characters: CharactersDTO?
    let stories: StoriesDTO?
    let events: CharactersDTO?

    enum CodingKeys: String, CodingKey {
        case id 
        case digitalID = "digitalId"
        case title
        case issueNumber
        case variantDescription
        case description
        case isbn
        case upc
        case ean
        case issn
        case pageCount
        case resourceURI
        case urls
        case series
        case variants
        case collectedIssues
        case dates
        case thumbnail
        case images
        case creators
        case characters
        case stories
        case events
    }
}

// MARK: - CharactersDTO
struct CharactersDTO: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [SeriesDTO]?
    let returned: Int?
}

// MARK: - SeriesDTO
struct SeriesDTO: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - CreatorsDTO
struct CreatorsDTO: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsItemDTO]?
    let returned: Int?
}

// MARK: - CreatorsItem
struct CreatorsItemDTO: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?
}


// MARK: - DateElement
struct DateElement: Codable {
    let type: DateType
    let date: String?
}

enum DateType: String, Codable {
    case digitalPurchaseDate = "digitalPurchaseDate"
    case focDate = "focDate"
    case onsaleDate = "onsaleDate"
    case unlimitedDate = "unlimitedDate"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Stories
struct StoriesDTO: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItemDTO]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItemDTO: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}


// MARK: - URLElement
struct URLElement: Codable {
    let type: String?
    let url: String?
}

// MARK: - Mappings to Domain
extension ComicResponseDTO {
    func toDomain() -> Comic {
        let id = id
        let comicTitle = title ?? ""
        var thumbnailPath = ""
        if let thumbnail = thumbnail?.path{
            thumbnailPath = "\(thumbnail).jpg"
        }

        var releaseDate: String?
        if let dateElement = dates?.first(where: { $0.type == .focDate }), let dateString = dateElement.date {
            releaseDate = dateString.convertToFormattedDateString()
        }
        
        return Comic(id: id, title: comicTitle, thumbnail: thumbnailPath, isExpanded: false, releaseDate: releaseDate ?? "")
    }
}



