//
//  ComicDetailsUseCase.swift
//  Marvel
//
//  Created by Mac on 17/06/2023.
//

import Foundation

class ComicDetailsUseCase: DefaultComicDetailsUseCase {
    typealias T = Comic
    
    @Injected(\.comicsRepo) var comicsRepo
    
    init(comicsRepo: DefaultComicsRepository) {
        self.comicsRepo = comicsRepo
    }
    
    func execute(id: Int) async throws -> T {
            let comic = try await comicsRepo.fetchComicDetails(id: id)
            return comic
    }

}
