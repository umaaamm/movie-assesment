//
//  TextRating.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import SwiftUI

struct RatingText: View {
  
  let vote_average: String
  let large: Bool
  var rating: Int { Int(Double(vote_average)! * 10)}
  
  
  init(vote_average: String, large: Bool = false) {
    self.vote_average = vote_average
    self.large = large
  }
  var title: String {
    large ? "\(rating)% User Score" : "\(rating)%"
  }
  var scoreColor: Color {
    get {
      if rating < 40 {
          return .red
      } else if rating < 60 {
          return .orange
      } else if rating < 75 {
          return .yellow
      }
        return .green
    }
  }
  var body: some View {
    Text(title)
      .foregroundColor(scoreColor)
      .font(.title)
  }
}

