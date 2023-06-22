//
//  ViewController+SearchBar.swift
//  Marvel
//
//  Created by Mac on 20/06/2023.
//

import UIKit

extension ViewController: UISearchBarDelegate{

    func setupSearchBar(){
        comicsSearchBar.delegate = self
        comicsSearchBar.layer.cornerRadius = 5
        comicsSearchBar.backgroundImage = UIImage()
        comicsSearchBar.layer.borderColor = .none
        comicsSearchBar.placeholder = AppString.ComicsScreen.searchComics
        comicsSearchBar.barTintColor = UIColor.white
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input.send(.filterComics(searchBar.text ?? "", limit))
        showLoader()
        comicsSearchBar.endEditing(true)

    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
         input.send(.loadComics(limit))
         showLoader()
         comicsSearchBar.endEditing(true)
        }
    }
    
}

