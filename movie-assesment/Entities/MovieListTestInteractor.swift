//
//  MovieListFakeInteractor.swift
//  movie-assesmentTests
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

@testable import movie_assesment

import Combine
import SwiftUI

class MovieListTestInteractor: ObservableObject, MovieListInteractorProtocol {
    func fetchDataFromGenre(id: Int) -> AnyCancellable {
        return self.getPopular().on(queue: .main)
      .on(success: { [weak self] data in
        print(data)
        self?.sucess(for: data.results)
      }, failure: { [weak self] error in
        print(error)
        self?.error(for: error)
      })
    }
    
  @Published var model: MovieListViewModel
  
  var data: ResponseEntity
  init(model: MovieListViewModel) {
    self.model = model
    self.data = MovieEntity.fakes.toMain()
  }
  
  convenience init(model: MovieListViewModel,movies: [MovieEntity]) {
    self.init(model: model)
    self.data = movies.toMain()
  }
  
  func error(for apiError: ApiError) {
    self.model.error = apiError
  }
  
  func sucess(for movies: [MovieEntity]) {
    self.model.movies = movies
  }
  func getPopular()  -> AnyPublisher<ResponseEntity, ApiError>{

    return Just((self.data))
                .setFailureType(to: ApiError.self)
                .eraseToAnyPublisher()
  }
  
  func fetchData() -> AnyCancellable{
    return self.getPopular().on(queue: .main)
  .on(success: { [weak self] data in
    print(data)
    self?.sucess(for: data.results)
  }, failure: { [weak self] error in
    print(error)
    self?.error(for: error)
  })
  }
}


extension Array where Element == MovieEntity {
    func toMain() -> ResponseEntity {
      return ResponseEntity(page: 1, results: self)
    }
}
