//
//  Comic.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation

struct Comic: Codable,Hashable {
    let id: Int
    let title: String
    let thumbnail: String
    var isExpanded: Bool
    let releaseDate: String
    
}


