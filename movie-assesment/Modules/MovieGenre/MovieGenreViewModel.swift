//
//  MovieGenreViewModel.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 03/02/23.
//

import Foundation
import Combine
import SwiftUI

final class MovieGenreViewModel: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var error: ApiError? = nil {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var moviesGenre: [Genre] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    
    func error(for apiError: ApiError) {
        self.error = apiError
    }
    
    func sucess(for moviesGenre: [Genre]) {
        self.moviesGenre = moviesGenre
    }
    
}
