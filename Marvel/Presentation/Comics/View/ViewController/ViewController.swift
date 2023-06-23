//
//  ViewController.swift
//  Marvel
//
//  Created by Mac on 15/06/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @Injected(\.comicsVM) var vm

    let input: PassthroughSubject<ComicsViewModel.Input, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    var comics: [Comic] = []
    var allComics: [Comic] = []
    var filteredComics: [Comic] = []
    var comic: Comic?
    var oldValue : Int = -1
    var isFetchingData = false
    var limit = 0
    var didSelectComic = false
    var isDetailsFetching = false
    var activityView: UIActivityIndicatorView?


    @IBOutlet weak var comicsTableView: UITableView!
    @IBOutlet weak var comicsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     setupComicsTableView()
     setupSearchBar()
     bind()
    }
    
 
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
        showLoader()
        input.send(.loadComics(limit))
    }
    
    private func bind() {
      let output = vm.transform(input: input.eraseToAnyPublisher())
      output
        .receive(on: DispatchQueue.main)
        .sink {[weak self] event in
            guard let self = self else {return}
            self.showLoader()
        switch event {
            
        case .fetchComicsDidFail(let error):
            self.showError(error: error)
            
        case .fetchComicsDidSucceed(let comics):
            self.handleFetchingAllComics(comics: comics)
            
        case .selectComicDidSucceed:
            self.handleFetchingComicDetails()
            
        case .selectComicDidFail(error: let error):
            self.showError(error: error)
            
        case .filterComicsDidSucceed(comics: let comics):
            self.handleFetchingFilteredComics(comics: comics)
            
        case .filterComicsDidFail(error: let error):
            self.showError(error: error)
        }
            self.hideLoader()
      }.store(in: &cancellables)
      
    }
    
}

extension ViewController {
    
   private func handleFetchingAllComics(comics: [Comic]) {
        self.limit += 20
        self.comics = []
        self.allComics.append(contentsOf: comics)
        self.comics = self.allComics
        self.isFetchingData = false
        self.comicsTableView.reloadData()
    }
    
    private func handleFetchingComicDetails() {
        self.isDetailsFetching = false
        self.comicsTableView.reloadRows(at: [IndexPath(row: self.oldValue, section: 0) ], with: .automatic)
    }
    
    private func handleFetchingFilteredComics(comics: [Comic]){
        if comics.isEmpty {
            self.showErrorAlert(error: AppString.Error.noAvailableData)
        }
        self.filteredComics = comics
        self.comics = self.filteredComics
        self.comicsTableView.reloadData()
    }
}
