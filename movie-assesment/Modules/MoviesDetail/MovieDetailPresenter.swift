//
//  MovieDetailPresenter.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation
import Combine
import SwiftUI

protocol MovieDetailPresenterProtocol {
    
    init(interactor: MovieDetailInteractorProtocol)
    var MovieDetailPresenterStatePublished: Published<MovieDetailPresenterStateEnum>.Publisher {get}
    
    var moviesVideos: [ResultVideosEntity] {get set}
    var error: ApiError? { get set }
    var interactor: MovieDetailInteractorProtocol {get set}
    func fetchData(id: Int)
    func fetcDataReview(id: Int)
    var moviesReviews: [ReviewsEntity] {get set}

}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
   
    
    var MovieDetailPresenterStatePublished: Published<MovieDetailPresenterStateEnum>.Publisher {$movieDetailPresenterState}
    
    var interactor: MovieDetailInteractorProtocol
    var request: AnyCancellable?
    
    
    @Published var movieDetailPresenterState: MovieDetailPresenterStateEnum = .loading

    private var cancellables = Set<AnyCancellable>()
    
    @Published var moviesVideos: [ResultVideosEntity] = [] {
        didSet{
            if(moviesVideos != []){
//                movieDetailPresenterState = .sucess
                print("check data")
            }
        }
    }
    
    @Published var moviesReviews: [ReviewsEntity] = [] {
        didSet{
            if(moviesReviews != []){
                movieDetailPresenterState = .sucess
            }
        }
    }
    
    @Published var error: ApiError? {
        didSet{
            if(error != nil){
                movieDetailPresenterState = .error
            }
        }
    }
    
    init(interactor: MovieDetailInteractorProtocol) {
        self.interactor = interactor
        self.bindVariablesToModel()
    }
    
    func fetchData(id: Int) {
        request = self.interactor.fetchDataVideos(id: id)
    }
    
    func fetcDataReview(id: Int) {
        request = self.interactor.fetchDataReview(id: id)
    }
    
    func bindVariablesToModel(){
        self.interactor.model.$moviesVideos
            .assign(to: \.moviesVideos, on: self)
            .store(in: &cancellables)
        self.interactor.model.$error
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
        self.interactor.model.$moviesReviews.assign(to: \.moviesReviews, on: self).store(in: &cancellables)
    }
    
}

public enum MovieDetailPresenterStateEnum {
    case empty, sucess, error, loading
}
