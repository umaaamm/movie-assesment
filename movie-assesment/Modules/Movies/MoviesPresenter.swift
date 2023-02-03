//
//  MoviesPresenter.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation
import Combine
import SwiftUI

protocol MovieListPresenterProtocol {
    
    init(interactor: MovieListInteractorProtocol)
    var MoviePresenterStatePublished: Published<MoviePresenterStateEnum>.Publisher {get}
    var movies: [MovieEntity] {get set}
    var error: ApiError? { get set }
    
    var router: MovieListRouter {get set}
    var interactor: MovieListInteractorProtocol {get set}
    
    func fetchData()
    
    func linkBuilder<Content: View>(for movie: MovieEntity, @ViewBuilder content: () -> Content
    ) -> NavigationLink<Content,AnyView>
    
}

final class MovieListPresenter: MovieListPresenterProtocol {
    
    var router: MovieListRouter =  MovieListRouter()
    var interactor: MovieListInteractorProtocol
    var request: AnyCancellable?
    
    var MoviePresenterStatePublished:Published<MoviePresenterStateEnum>.Publisher {$moviePresenterState}
    
    @Published var moviePresenterState: MoviePresenterStateEnum = .loading
    private var cancellables = Set<AnyCancellable>()
    
    @Published var movies: [MovieEntity] = [] {
        didSet{
            if(movies != []){
                moviePresenterState = .sucess
            }
        }
    }
    
    @Published var error: ApiError? {
        didSet{
            if(error != nil){
                moviePresenterState = .error
            }
        }
    }
    
    
    init(interactor: MovieListInteractorProtocol) {
        self.interactor = interactor
        self.bindVariablesToModel()
    }
    
    func fetchData() {
        request = self.interactor.fetchData()
    }
    
    func linkBuilder<Content>(for movie: MovieEntity, content: () -> Content) -> NavigationLink<Content, AnyView> where Content : View {
        NavigationLink(destination: AnyView(router.makeDetailView(for: movie))) {
            content()
        }
    }
    
    func bindVariablesToModel(){
        self.interactor.model.$movies
            .assign(to: \.movies, on: self)
            .store(in: &cancellables)
        self.interactor.model.$error
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
    }
    
    
}

public enum MoviePresenterStateEnum {
    case empty, sucess, error, loading
}
