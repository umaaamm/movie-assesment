//
//  ResponseEntity.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 01/02/23.
//

import Foundation

struct ResponseEntity: Codable {
  let page: Int
  let results: [MovieEntity]
}
