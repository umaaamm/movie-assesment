//
//  MovieGenrePresenter.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 03/02/23.
//

import Foundation
import Combine
import SwiftUI

protocol MovieGenrePresenterProtocol {
    
    init(interactor: MovieGenreInteractorProtocol)
    var MovieGenrePresenterStatePublished: Published<MovieGenrePresenterStateEnum>.Publisher {get}
    
    var moviesGenre: [Genre] {get set}
    var error: ApiError? { get set }
    var interactor: MovieGenreInteractorProtocol {get set}
    func fetchData()
    func linkBuilder<Content: View>(for movie: Genre, @ViewBuilder content: () -> Content
    ) -> NavigationLink<Content,AnyView>
}

final class MovieGenrePresenter: MovieGenrePresenterProtocol {
    var router: MovieGenreRouter =  MovieGenreRouter()
    
    
    func linkBuilder<Content>(for movieGenre: Genre, content: () -> Content) -> NavigationLink<Content, AnyView> where Content : View {
        NavigationLink(destination: AnyView(router.makeDetailViewFromGenre(for: movieGenre))) {
            content()
        }
    }
    
    var MovieGenrePresenterStatePublished: Published<MovieGenrePresenterStateEnum>.Publisher {$movieGenrePresenterState}
    
    var interactor: MovieGenreInteractorProtocol
    var request: AnyCancellable?
    
    
    @Published var movieGenrePresenterState: MovieGenrePresenterStateEnum = .loading
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var moviesGenre: [Genre] = [] {
        didSet{
            if(moviesGenre != []){
                movieGenrePresenterState = .sucess
            }
        }
    }
    
    @Published var error: ApiError? {
        didSet{
            if(error != nil){
                movieGenrePresenterState = .error
            }
        }
    }
    
    init(interactor: MovieGenreInteractorProtocol) {
        self.interactor = interactor
        self.bindVariablesToModel()
    }
    
    func fetchData() {
        request = self.interactor.fetchDataGenre()
    }
    
    func bindVariablesToModel(){
        self.interactor.model.$moviesGenre
            .assign(to: \.moviesGenre, on: self)
            .store(in: &cancellables)
        self.interactor.model.$error
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
    }
    
}

public enum MovieGenrePresenterStateEnum {
    case empty, sucess, error, loading
}
