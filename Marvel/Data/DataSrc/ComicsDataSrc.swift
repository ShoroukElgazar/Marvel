//
//  ComicsDataSrc.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import Foundation

protocol DefaultComicsDataSrc {
    func fetchComics(limit: Int) async throws -> [ComicResponseDTO]?
    func fetchComicDetails(id: Int)  async throws -> AppResponseDTO<ComicDetailsResponseDTO>?
}

class ComicsRemoteDataSrc: DefaultComicsDataSrc{
    public let apiService: ComicsAPIProvider
    @Injected(\.comicsCache) var cache
    
    init(apiService: ComicsAPIProvider = ComicsAPIProvider.create() ) {
        self.apiService = apiService
    }
    
   func fetchComics(limit: Int) async throws -> [ComicResponseDTO]? {
       let comics: AppResponseDTO<ComicsResponseDTO> = try await apiService.request(target: .comics(page: limit))
       return comics.data.comics
       
    }
    
    func fetchComicDetails(id: Int) async throws -> AppResponseDTO<ComicDetailsResponseDTO>? {
       
            let comic: AppResponseDTO<ComicDetailsResponseDTO> = try await apiService.request(target: .comicsDetails(id: id))
            return comic
        }

}

class ComicsCachedDataSrc: DefaultComicsDataSrc{
    public let apiService: ComicsAPIProvider
    @Injected(\.comicsCache) var cache
    
    init(apiService: ComicsAPIProvider = ComicsAPIProvider.create() ) {
        self.apiService = apiService
    }
    
    func fetchComics(limit: Int) async throws -> [ComicResponseDTO]? {
       guard let comics: [ComicResponseDTO] =
            cache.getCachedComics() else {
           return nil
       }
        return comics
    }
    
    func fetchComicDetails(id: Int) async throws -> AppResponseDTO<ComicDetailsResponseDTO>? {
            guard let comic = cache.getCachedDetails(id: id) else {return nil}
            return comic
      }
}

