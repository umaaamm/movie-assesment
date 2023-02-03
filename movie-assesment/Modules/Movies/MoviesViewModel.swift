//
//  MoviesViewModel.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation
import Combine
import SwiftUI

final class MovieListViewModel: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var error: ApiError? = nil {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var movies: [MovieEntity] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    func error(for apiError: ApiError) {
        self.error = apiError
    }
    
    func sucess(for movies: [MovieEntity]) {
        self.movies = movies
    }
    
}
