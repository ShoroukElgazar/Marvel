//
//  DefaultComicDetailsUseCase.swift
//  Marvel
//
//  Created by Mac on 19/06/2023.
//

import Foundation

protocol DefaultComicDetailsUseCase {
    associatedtype T: Codable
    
    func execute(id: Int) async throws -> T
}
