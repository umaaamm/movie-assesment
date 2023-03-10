//
//  MoviesGenre.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation

enum MoviesGenre: Int, CaseIterable{
  case action = 28,
       adventure = 12,
       animation = 16,
       comedy = 35,
       crime = 80,
       documentary = 99,
       drama = 18,
       family = 10751,
       fantasy = 14,
       history = 36,
       horror = 27,
       music = 10402,
       mystery = 9648,
       romance = 10749,
       scienceFiction = 878,
       tvMovie = 10770,
       thriller = 53,
       war = 10752,
       western = 37

  
  private static var dictConverter: [MoviesGenre: String] {
    [self.action : "Action",
     self.adventure: "Adventure",
     self.animation: "Animation",
     self.comedy: "Comedy",
     self.crime: "Crime",
     self.documentary: "Documentary",
     self.drama: "Drama",
     self.family: "Family",
     self.fantasy: "Fantasy",
     self.history: "History",
     self.horror: "Horror",
     self.music: "Music",
     self.mystery: "Mystery",
     self.romance: "Romance",
     self.scienceFiction: "Science Fiction",
     self.tvMovie: "TV Movie",
     self.thriller: "Thriller",
     self.war: "War",
     self.western: "Western"]
  }
}

extension MoviesGenre {
  static func toString(for movie: MoviesGenre?) -> String {
    if let movie = movie{
      return MoviesGenre.dictConverter[movie] ?? ""
    }
     return ""
  }
  
  static var getRandom: MoviesGenre {
      MoviesGenre.allCases.randomElement()!
  }
}
