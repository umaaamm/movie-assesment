// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resultVideosEntity = try? JSONDecoder().decode(ResultVideosEntity.self, from: jsonData)

import Foundation

// MARK: - ResultVideosEntityElement
class ResultVideosEntity: Codable, Identifiable, Hashable {
    let name, key: String
    let id: String
    
    
    init(name: String, key: String, id: String) {
        self.name = name
        self.key = key
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        key = try values.decode(String.self, forKey: .key)
    }
}

extension ResultVideosEntity {
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: ResultVideosEntity, rhs: ResultVideosEntity) -> Bool {
      lhs.id == rhs.id
    }
    
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case key
  }
}

