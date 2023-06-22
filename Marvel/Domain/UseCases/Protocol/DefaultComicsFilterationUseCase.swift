//
//  DefaultComicsFilterationUseCase.swift
//  Marvel
//
//  Created by Mac on 19/06/2023.
//

import Foundation

protocol DefaultComicsFilterationUseCase {
    associatedtype T: Codable
    
    func execute(limit: Int,text: String) async throws -> T
}
