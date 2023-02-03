//
//  VideosEntity.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation

struct VideosEntity: Codable {
    
    var id      : Int?       = nil
    var results : [ResultVideosEntity]? = []
    
    enum CodingKeys: String, CodingKey {
        
        case id      = "id"
        case results = "results"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id      = try values.decodeIfPresent(Int.self       , forKey: .id      )
        results = try values.decodeIfPresent([ResultVideosEntity].self , forKey: .results )
        
    }
    
    init() {
        
    }
    
}
