//
//  DefaultComicsUseCase.swift
//  Marvel
//
//  Created by Mac on 19/06/2023.
//

import Foundation

protocol DefaultComicsUseCase {
    associatedtype T: Codable
    
    func execute(limit: Int) async throws -> T
}
