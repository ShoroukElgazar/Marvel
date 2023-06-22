//
//  ComicsFilterationUseCase.swift
//  Marvel
//
//  Created by Mac on 16/06/2023.
//

import Foundation

class ComicsFilterationUseCase: DefaultComicsFilterationUseCase {
    typealias T = [Comic]

    var text: String = ""
    @Injected(\.comicsRepo) var comicsRepo
    
    init(comicsRepo: DefaultComicsRepository) {
        self.comicsRepo = comicsRepo
    }
    
    func filterComics(text: String,limit: Int) async throws -> [Comic]{
            let comics = try await comicsRepo.fetchFilteredComics(limit: limit)
          let filteredComics = comics.filter{ comic in
              (comic.title.lowercased().contains(text.lowercased()))
            }
            return filteredComics
    }
    
    func execute(limit: Int,text: String) async throws -> T {
            let comic = try await filterComics(text: text, limit: limit)
            return comic
    }

}

