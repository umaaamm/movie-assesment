//
//  ReviewsEntity.swift
//  movie-assesment
//
//  Created by Kurniawan Gigih Lutfi Umam on 02/02/23.
//

import Foundation


// MARK: - Result
class ReviewsEntity: Codable, Identifiable, Hashable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
    
    var createDate: String? {
        return Formatter.releaseYear(from: createdAt ?? "")
    }

    init(author: String?, authorDetails: AuthorDetails?, content: String?, createdAt: String?, id: String?, updatedAt: String?, url: String?) {
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
    }
}

// MARK: - AuthorDetails
class AuthorDetails: Codable {
    let name, username: String?
    let avatarPath: String?
    let rating: Int?
    
    var imageURLAvatar: URL {
        return ServiceImages.getUrl(size: .small, for: avatarPath ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }

    init(name: String?, username: String?, avatarPath: String?, rating: Int?) {
        self.name = name
        self.username = username
        self.avatarPath = avatarPath
        self.rating = rating
    }
}

extension ReviewsEntity {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ReviewsEntity, rhs: ReviewsEntity) -> Bool {
        lhs.id == rhs.id
    }
}
