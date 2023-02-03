//
//  MovieDetailInteractor.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation
import Combine

protocol MovieDetailInteractorProtocol {
    var model: MovieDetailViewModel {get set}
    func error(for apiError: ApiError)
    func sucess(for moviesVideos: [ResultVideosEntity])
    func sucessReview(for moviesReview : [ReviewsEntity])
    func fetchDataVideos(id: Int) -> AnyCancellable
    func fetchDataReview(id: Int) -> AnyCancellable
}

class MovieDetailInteractor: ObservableObject, MovieDetailInteractorProtocol {
    
    func sucessReview(for moviesReview: [ReviewsEntity]) {
        self.model.moviesReviews = moviesReview
    }
    
    func fetchDataReview(id: Int) -> AnyCancellable {
        return self.getReview(id: id).on(queue: .main)
            .on(success: { [weak self] data in
                self?.sucessReview(for: data.results)
            }, failure: { [weak self] error in
                self?.error(for: error)
            })
    }
    
    @Published var model: MovieDetailViewModel
    
    
    init(model: MovieDetailViewModel) {
        self.model = model
    }
    
    func error(for apiError: ApiError) {
        self.model.error = apiError
    }
    
    func sucess(for moviesVideos: [ResultVideosEntity]) {
        self.model.moviesVideos = moviesVideos
    }
    
    func getVideos(id: Int)  -> AnyPublisher<ResponseVideosEntity, ApiError>{
        return ServicesSupport.shared.run(Router.videos(id: id))
    }
    
    func getReview(id: Int)  -> AnyPublisher<ResponseReviewEntity, ApiError>{
        return ServicesSupport.shared.run(Router.review(id: id))
    }
    
    func fetchDataVideos(id: Int) -> AnyCancellable{
        return self.getVideos(id: id).on(queue: .main)
            .on(success: { [weak self] data in
                self?.sucess(for: data.results)
            }, failure: { [weak self] error in
                self?.error(for: error)
            })
    }
    
}
