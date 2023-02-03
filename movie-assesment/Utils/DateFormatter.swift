//
//  DateFormatter.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation

struct Formatter {
  static private var yearFormatter: DateFormatter  {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
  }
  
static func releaseYear(from releaseDate:String) -> String? {
    guard let date = self.dateFormatter.date(from: releaseDate) else{
      return nil
    }
    return self.yearFormatter.string(from: date)
  }
    
    static private var dateFormatter: DateFormatter  {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      return formatter
    }
}
