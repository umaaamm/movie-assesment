//
//  MovieNavigatePresenter.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 02/02/23.
//

import Foundation

class MovieNavigatePresenter: ObservableObject {
  
  @Published var movie: MovieEntity
  
  init(movie: MovieEntity) {
    self.movie = movie
  }
}
