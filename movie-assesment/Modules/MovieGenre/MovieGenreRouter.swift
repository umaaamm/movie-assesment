//
//  MovieGenreRouter.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 03/02/23.
//

import Foundation

import SwiftUI

class MovieGenreRouter {
    func makeDetailViewFromGenre(for genre: Genre) -> some View {
        let viewModel = MovieListViewModel()
        let interactor = MovieListInteractor(model: viewModel)
        let presenter = MovieListPresenter(interactor: interactor)
        return MoviesView(presenter: presenter, dataGenre: genre, fromGenre: true)
    }
}
