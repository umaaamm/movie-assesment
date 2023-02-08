//
//  GenreEntity.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 03/02/23.
//

import Foundation
// MARK: - GenreEntity
struct GenreEntity: Codable {
    let genres: [Genre]

//    init(genres: [Genre]) {
//        self.genres = genres
//    }
}

// MARK: - Genre
class Genre:  Codable, Identifiable, Hashable {
    let id: Int?
    let name: String?

    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}


extension Genre {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        lhs.id == rhs.id
    }
}
