//
//  MoviesRouter.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation
import SwiftUI

class MovieListRouter {
    func makeDetailView(for movie: MovieEntity) -> some View {
        let viewModel = MovieDetailViewModel()
        let interactor = MovieDetailInteractor(model: viewModel)
        let presenter = MovieDetailPresenter(interactor: interactor)
        presenter.fetchData(id: movie.id)
        return MovieDetailView(presenter: presenter, dataMovie: movie)
    }
}
