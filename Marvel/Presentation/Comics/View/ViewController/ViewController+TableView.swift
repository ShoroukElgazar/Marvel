//
//  ViewController+TableView.swift
//  Marvel
//
//  Created by Mac on 20/06/2023.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching{
    
    func setupComicsTableView(){
        comicsTableView.dataSource = self
        comicsTableView.delegate = self
        comicsTableView.prefetchDataSource = self
        comicsTableView.register(UINib(nibName: "ComicCell", bundle: nil), forCellReuseIdentifier: "ComicCell")
        comicsTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.last, lastIndexPath.row >= allComics.count - 3 && !isFetchingData && limit <= 75 {
            showLoader()
            handleComicsPrefetching()
            input.send(.loadComics(limit))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ComicCell = tableView.dequeueReusableCell(withIdentifier: "ComicCell", for: indexPath) as! ComicCell
        
        cell.configCell(thumbnail: comics[indexPath.row].thumbnail)
        
        if didSelectComic {
            cell.configCell(thumbnail: comics[indexPath.row].thumbnail, isExpanded: comics[indexPath.row].isExpanded,title: comics[indexPath.row].title,date: comics[indexPath.row].releaseDate, isFetching: isDetailsFetching)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isDetailsFetching = true
        self.comic = comics[indexPath.row]
        guard let comic = comic else{
            return
        }
        input.send(.selectComic(comic.id))
        handleComicExpansion(indexPath: indexPath)
    }

    private func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func handleComicsPrefetching() {
        self.limit += 15
        isFetchingData = true
    }
    
    private func handleComicExpansion(indexPath: IndexPath) {
        let newValue = indexPath.row
        if comic?.isExpanded == false{
            didSelectComic = true
            if oldValue == newValue {
                comics[newValue].isExpanded.toggle()
            } else {
                if  oldValue != -1 {
                    comics[oldValue].isExpanded = false
                }
                comics[newValue].isExpanded = true
                oldValue = newValue
            }
            comicsTableView.reloadData()
        }else{
            didSelectComic = true
            if oldValue == newValue {
                comics[newValue].isExpanded.toggle()
            }
            self.comicsTableView.reloadRows(at: [IndexPath(row: newValue, section: 0) ], with: .automatic)
        }
    }
}
