//
//  ResponseVideosEntity.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation

struct ResponseVideosEntity: Codable {
  let id: Int
  let results: [ResultVideosEntity]
}
