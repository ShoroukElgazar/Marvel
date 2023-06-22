//
//  ComicsViewModel.swift
//  Marvel
//
//  Created by Mac on 16/06/2023.
//

import Combine

protocol DefaultComicsViewModel {
    func transform(input: AnyPublisher<ComicsViewModel.Input, Never>) -> AnyPublisher<ComicsViewModel.Output, Never>

}

class ComicsViewModel: DefaultComicsViewModel, ObservableObject {
    
    var comicsUseCase: any DefaultComicsUseCase
    var comicDetailsUseCase: any DefaultComicDetailsUseCase
    var filtercomicsUseCase: any DefaultComicsFilterationUseCase
    
    private let output: PassthroughSubject<Output, Never> = .init()
    let loadPublisher: PassthroughSubject<Loader, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    enum Input {
        case loadComics(Int)
        case selectComic(Int)
        case filterComics(String,Int)
    }
    
    enum Output {
        case fetchComicsDidSucceed(comics: [Comic])
        case fetchComicsDidFail(error: Error)
        case selectComicDidSucceed(comic: Comic)
        case selectComicDidFail(error: Error)
        case filterComicsDidSucceed(comics: [Comic])
        case filterComicsDidFail(error: Error)
    }
    
    enum Loader {
        case load
        case finish
    }
    
    
    init(comicsUseCase: any DefaultComicsUseCase, comicDetailsUseCase:  any DefaultComicDetailsUseCase,filtercomicsUseCase: any DefaultComicsFilterationUseCase) {
        self.comicsUseCase = comicsUseCase
        self.comicDetailsUseCase = comicDetailsUseCase
        self.filtercomicsUseCase = filtercomicsUseCase
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            self?.loadPublisher.send(.load)
            switch event {
            case let .loadComics(limit):
                Task { [weak self] in
                    guard let self = self else { return }
                    await fetchComics(limit: limit)
                }
            case let .selectComic(id):
                Task { [weak self] in
                    guard let self = self else { return }
                    await fetchComic(id: id)
                }
            case let .filterComics(text, limit):
                Task { [weak self] in
                    guard let self = self else { return }
                    await fetchFilteredComics(text: text, limit: limit)
                }
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func fetchComics(limit: Int) async {
        do {
            let comics = try await self.loadComics(limit: limit)
            self.output.send(.fetchComicsDidSucceed(comics: comics))
                        
        } catch {
            self.output.send(.fetchComicsDidFail(error: error))
        }
        
    }
    
    private func fetchFilteredComics(text: String,limit: Int) async {
        do {
            guard let comics = try await self.loadFilterdComics(text: text, limit: limit) else {return}
            self.output.send(.filterComicsDidSucceed(comics: comics))
                        
        } catch {
            self.output.send(.filterComicsDidFail(error: error))
        }
        
    }
    
    private func loadComics(limit: Int) async throws -> [Comic] {
        do {
            guard let comics: [Comic] = try await comicsUseCase.execute(limit: limit) as? [Comic] else { return [] }
            return comics
        } catch (let error) {
            throw(error)
        }
    }
    
    private func fetchComic(id:Int) async {
        do {
            guard let comic = try await self.loadComic(id: id) else {return}
            self.output.send(.selectComicDidSucceed(comic: comic))
        } catch {
            self.output.send(.selectComicDidFail(error: error))
        }
    }
    
    private func loadComic(id: Int) async throws -> Comic? {
        do {
            guard let comic: Comic = try await comicDetailsUseCase.execute(id: id) as? Comic else { return nil }
            return comic
        } catch (let error) {
            throw(error)
        }
    }
    
    private func loadFilterdComics(text: String,limit: Int) async throws -> [Comic]? {
        do {
            guard let comic: [Comic] = try await filtercomicsUseCase.execute(limit: limit, text: text) as? [Comic] else { return nil }
            return comic
        } catch (let error) {
            throw(error)
        }
    }

}
