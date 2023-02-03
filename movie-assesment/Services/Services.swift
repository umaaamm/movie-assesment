//
//  Services.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation


enum Router: Equatable {
    case popular
    case review(id: Int)
    case videos(id: Int)

    var url: String {scheme+host}
    var apiKey: String {"e0fbe343b5da81336bd33336f637962c"}
    var scheme: String {API.scheme}
    var host: String {API.URL}
    
    var path: String {
        switch self {
        case .popular:
            return "/3/movie/popular"
        case let .review(id):
            return "/3/movie/\(id)/reviews"
        case let .videos(id):
            return "/3/movie/\(id)/videos"
        }
        
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .popular:
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "language", value: "en-US")]
        case .review:
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "language", value: "en-US")]
        case .videos:
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "language", value: "en-US"),
            ]
        }
    }
    
    var method: String {
        switch self {
        case .popular:
            return "GET"
        case .review:
            return "GET"
        case .videos:
            return "GET"
        }
    }
}

struct API {
    static var schemeURL: String {scheme + "://" + URL}
    static var scheme: String {return "https"}
    static var URL: String {
        "api.themoviedb.org"
    }
}
