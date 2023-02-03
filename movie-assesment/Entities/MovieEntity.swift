//
//  MovieEntity.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation

class MovieEntity:  Codable, Identifiable, Hashable {
    
    let id: Int
    let original_title: String
    let title: String
    let overview: String
    let popularity: Double
    let vote_average: String
    let vote_count: Int
    let poster: String
    let release_date: String
    let genre: String
    let backdrop_path: String
    
    var releaseYear: String? {
        return Formatter.releaseYear(from: release_date)
    }
    var imageURL: URL {
        return ServiceImages.getUrl(for: poster)
    }
    
    var imageURLBackDrop: URL {
        return ServiceImages.getUrl(size: .original, for: backdrop_path)
    }
    
    init(id: Int, original_title: String, title: String, overview: String, popularity: Double, vote_average: String, vote_count: Int, poster: String, release_date: String, genre: MoviesGenre, backdrop_path: String) {
        self.id = id
        self.title = title
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.vote_average = vote_average
        self.vote_count = vote_count
        self.poster = poster
        self.release_date = release_date
        self.genre = MoviesGenre.toString(for: genre)
        self.backdrop_path = backdrop_path
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        original_title = try values.decode(String.self, forKey: .original_title)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        popularity = try values.decode(Double.self, forKey: .popularity)
        vote_average = String(try values.decode(Double.self, forKey: .vote_average))
        vote_count = try values.decode(Int.self, forKey: .vote_count)
        poster = try values.decode(String.self, forKey: .poster)
        backdrop_path = try values.decode(String.self, forKey: .backdrop_path)
        release_date = try values.decode(String.self, forKey: .release_date)
        
        let genre_id = (try? values.decode([Int].self, forKey: .genre)).map{ MoviesGenre.init(rawValue: $0.first ?? -1)}
        
        var res: String = ""
        if let genre_type = genre_id {
            res = MoviesGenre.toString(for: genre_type)
        }
        genre = res
    }
}

extension MovieEntity {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MovieEntity, rhs: MovieEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case original_title
        case title
        case overview
        case popularity
        case vote_average
        case vote_count
        case genre = "genre_ids"
        case poster = "poster_path"
        case release_date
        case backdrop_path
    }
}
