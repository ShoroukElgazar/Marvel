//
//  ComicsDIContainer.swift
//  Marvel
//
//  Created by Mac on 17/06/2023.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    var wrappedValue: T
    
    init(_ keyPath: KeyPath<ComicsDIContainer, T>) {
        wrappedValue = ComicsDIContainer.shared[keyPath: keyPath]
    }
}

class ComicsDIContainer {
    static let shared: ComicsDIContainer = .init()
    
    lazy var comicsRepo: DefaultComicsRepository = ComicsRepo(cachedSrc: ComicsCachedDataSrc(), remoteSrc: ComicsRemoteDataSrc())
    
    lazy var comicsVM: DefaultComicsViewModel = ComicsViewModel(comicsUseCase: ComicsUseCase(comicsRepo: ComicsRepo(cachedSrc: ComicsCachedDataSrc(), remoteSrc: ComicsRemoteDataSrc())), comicDetailsUseCase: ComicDetailsUseCase(comicsRepo:  ComicsRepo(cachedSrc: ComicsCachedDataSrc(), remoteSrc: ComicsRemoteDataSrc())), filtercomicsUseCase: ComicsFilterationUseCase(comicsRepo: ComicsRepo(cachedSrc: ComicsCachedDataSrc(), remoteSrc: ComicsRemoteDataSrc())))
    
    lazy var comicsCache = ComicsCache.shared
  
}


