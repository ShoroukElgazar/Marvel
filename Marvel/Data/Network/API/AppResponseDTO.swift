//
//  AppResponseDTO.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation

 struct AppResponseDTO<T: Codable>: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: T
}

