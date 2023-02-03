//
//  MovieDetailViewModel.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation
import Combine
import SwiftUI

final class MovieDetailViewModel: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var error: ApiError? = nil {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var moviesVideos: [ResultVideosEntity] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var moviesReviews: [ReviewsEntity] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    func error(for apiError: ApiError) {
        self.error = apiError
    }
    
    func sucess(for moviesVideos: [ResultVideosEntity]) {
        self.moviesVideos = moviesVideos
    }
    
    func sucessReview(for moviesReviews: [ReviewsEntity]) {
        self.moviesReviews = moviesReviews
    }
    
}
