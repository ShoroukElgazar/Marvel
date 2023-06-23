//
//  CacheManager.swift
//  Marvel
//
//  Created by Mac on 17/06/2023.
//

import Foundation

protocol DefaultComicsCache {
    func getCachedComics() -> [ComicResponseDTO]?
    func getCachedDetails(id: Int) -> AppResponseDTO<ComicDetailsResponseDTO>?
}

class ComicsCache: DefaultComicsCache{
    
    static let shared: ComicsCache = .init()

    private let comicsCache = AppCache<String,[ComicResponseDTO]>()
    private let detailsCache = AppCache<String, AppResponseDTO<ComicDetailsResponseDTO>>()
    
    
    func cacheComics(comics: [ComicResponseDTO]) {
        comicsCache.insert(comics, forKey: "ComicsCache")
    }

    func getCachedComics() -> [ComicResponseDTO]? {
        return comicsCache.value(forKey: "ComicsCache")
    }
    
    func cacheComicsDetails(id: Int, comic: AppResponseDTO<ComicDetailsResponseDTO>) {
        detailsCache.insert(comic, forKey: "ComicsCacheDetails" + "\(id)")
        }

    func getCachedDetails(id: Int) -> AppResponseDTO<ComicDetailsResponseDTO>? {
        return detailsCache.value(forKey: "ComicsCacheDetails" + "\(id)")
    }

}
