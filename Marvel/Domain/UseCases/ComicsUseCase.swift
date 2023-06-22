//
//  ComicsUseCase.swift
//  Marvel
//
//  Created by Mac on 16/06/2023.
//

import Foundation

class ComicsUseCase: DefaultComicsUseCase {
    typealias T = [Comic]
    @Injected(\.comicsRepo) var comicsRepo
    
    init(comicsRepo: DefaultComicsRepository) {
        self.comicsRepo = comicsRepo
    }
    
    func execute(limit: Int) async throws -> [Comic] {
            let comics = try await comicsRepo.fetchComics(limit: limit)
            return comics

    }
    
    
}
