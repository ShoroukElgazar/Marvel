//
//  ComicsRepo.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation

struct ComicsRepo: DefaultComicsRepository{
    @Injected(\.comicsCache) var cache
    
    let cachedSrc: DefaultComicsDataSrc
    let remoteSrc: DefaultComicsDataSrc
    
    func fetchComics(limit: Int) async throws-> [Comic] {
        var comicList : [Comic] = []
        let comics = try await remoteSrc.fetchComics(limit: limit)
        guard let items = comics else{
                return []
            }
            cache.cacheComics(comics: items)
            let list = items.data.comics
            for comic in list{
                comicList.append(comic.toDomain())
            }
            return comicList
    }
    
    func fetchComicDetails(id: Int) async throws -> Comic {
        if let comic =  try await cachedSrc.fetchComicDetails(id: id)?.data.comics.first?.toDomain() {
                return comic
            }else{
                guard let comic =  try await remoteSrc.fetchComicDetails(id: id) else {
                    return Comic(id: 0, title: "", thumbnail: "", isExpanded: false, releaseDate: "")
                }
                cache.cacheComicsDetails(id: id, comic: comic)
             
                return comic.data.comics.first!.toDomain()
           
       }
       
    }
    
    func fetchFilteredComics(limit: Int) async throws-> [Comic] {
        var comicList : [Comic] = []
            let comics = try await cachedSrc.fetchComics(limit: limit)
        guard let items = comics?.data.comics else{
                return []
            }
            for comic in items{
                comicList.append(comic.toDomain())
            }
            return comicList
      
    }
    
}

