//
//  ServicesImages.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation

public class ServiceImages {
  static let baseURL = "https://image.tmdb.org/t/p/"
  
  public enum ImageSize: String{
    case small = "w154"
    case medium = "w500"
    case original = "original"
  }
  
  static func getUrl(size: ImageSize = .medium,for poster: String) -> URL {
    return URL(string: "\(baseURL)\(size.rawValue)")!.appendingPathComponent(poster)
  }
}
