//
//  ComicDetailsResponseDTO.swift
//  Marvel
//
//  Created by Mac on 18/06/2023.
//

import Foundation

// MARK: - ComicsDetailsResponseDTO
struct ComicDetailsResponseDTO: Codable {
    let offset, limit, total, count: Int?
    let comics: [ComicResponseDTO]
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case comics = "results"
    }
}
