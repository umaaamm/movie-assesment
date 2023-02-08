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
    var modelGenre = MovieGenreViewModel()
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    MoviesView(presenter:
                                MovieListPresenter(interactor:
                                                    MovieListInteractor(model: model)), dataGenre: Genre(id: 2, name: "Test"))
                    .background(Color.white
                        .edgesIgnoringSafeArea(.all))
                    
                }
                .tag(0).tabItem({
                    Image(systemName: "play.tv.fill")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Popular")
                })
                NavigationView {
                    MoviesGenreView(presenter:
                                        MovieGenrePresenter(interactor:
                                                                MovieGenreInteractor(model: modelGenre)))
                    .background(Color.white
                        .edgesIgnoringSafeArea(.all))
                    
                }
                .tag(1).tabItem({
                    Image(systemName: "tv.fill")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Genre")
                })
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
    
}
