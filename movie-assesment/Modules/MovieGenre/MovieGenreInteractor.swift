//
//  MovieInteractor.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 03/02/23.
//

import Foundation
import Combine

protocol MovieGenreInteractorProtocol {
    var model: MovieGenreViewModel {get set}
    func error(for apiError: ApiError)
    func sucess(for moviesGenre: [Genre])
    func fetchDataGenre() -> AnyCancellable
}

class MovieGenreInteractor: ObservableObject, MovieGenreInteractorProtocol {
    
    @Published var model: MovieGenreViewModel
    
    init(model: MovieGenreViewModel) {
        self.model = model
    }
    
    func error(for apiError: ApiError) {
        self.model.error = apiError
    }
    
    func sucess(for moviesGenre: [Genre]) {
        self.model.moviesGenre = moviesGenre
    }
    
    func fetchDataGenre() -> AnyCancellable {
        return self.getGenre().on(queue: .main)
            .on(success: { [weak self] data in
                self?.sucess(for: data.genres)
            }, failure: { [weak self] error in
                self?.error(for: error)
            })
    }
    
    func getGenre()  -> AnyPublisher<GenreEntity, ApiError>{
        return ServicesSupport.shared.run(Router.getListGenre)
    }
    
    
}
