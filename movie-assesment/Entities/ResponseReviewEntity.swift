//
//  ResponseReviewEntity.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 02/02/23.
//

import Foundation

struct ResponseReviewEntity: Codable {
    let id: Int
    let page: Int
    let results: [ReviewsEntity]
}
