//
//  movie_assesmentApp.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import SwiftUI

@main
struct movie_assesmentApp: App {
    var model = MovieListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MoviesView(presenter:
                            MovieListPresenter(interactor:
                                                MovieListInteractor(model: model)))
                .background(Color.white
                    .edgesIgnoringSafeArea(.all))
                
            }
        }
    }
    
}
