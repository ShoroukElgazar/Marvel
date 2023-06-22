//
//  ComicsRepository.swift
//  Marvel
//
//  Created by Mac on 16/06/2023.
//

import Foundation
 
protocol DefaultComicsRepository {
  func fetchComics(limit: Int)  async throws -> [Comic]
  func fetchComicDetails(id: Int)  async throws -> Comic
  func fetchFilteredComics(limit: Int) async throws -> [Comic]
}
