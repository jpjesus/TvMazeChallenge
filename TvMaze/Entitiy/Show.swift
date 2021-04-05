//
//  Show.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation

struct Show: Decodable {
    
    let id: Int
    let name: String
    let image: String
    let summary: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case images = "image"
        case image = "medium"
        case ratingScore = "rating"
        case summary
        case rating = "average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        summary = try container.decodeIfPresent(String.self, forKey: .summary) ?? ""
        let imageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .images)
        image = try imageContainer.decodeIfPresent(String.self, forKey: .image) ?? ""
        let ratingContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .ratingScore)
        rating = try ratingContainer.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
    }
}
