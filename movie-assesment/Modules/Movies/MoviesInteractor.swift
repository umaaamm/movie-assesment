//
//  MoviesInteractor.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation
import Combine

protocol MovieListInteractorProtocol {
    var model: MovieListViewModel {get set}
    
    func error(for apiError: ApiError)
    func sucess(for movies: [MovieEntity])
    func fetchData() -> AnyCancellable
}

class MovieListInteractor: ObservableObject, MovieListInteractorProtocol {
    @Published var model: MovieListViewModel
    
    init(model: MovieListViewModel) {
        self.model = model
    }
    
    func error(for apiError: ApiError) {
        self.model.error = apiError
    }
    
    func sucess(for movies: [MovieEntity]) {
        self.model.movies = movies
    }
    func getPopular()  -> AnyPublisher<ResponseEntity, ApiError>{
        return ServicesSupport.shared.run(Router.popular)
    }
    
    func fetchData() -> AnyCancellable{
        return self.getPopular().on(queue: .main)
            .on(success: { [weak self] data in
                self?.sucess(for: data.results)
            }, failure: { [weak self] error in
                self?.error(for: error)
            })
    }
}
