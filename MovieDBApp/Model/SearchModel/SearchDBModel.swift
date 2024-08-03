//
//  SearchDBModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import Foundation

struct SearchDBResults: Codable {
    let page: Int
    let results: [SearchDBModel]
}

struct SearchDBModel: Codable, Identifiable {
    let adult: Bool
    let id: Int
    let title: String?
    let overview: String
    let posterPath: String?
    let popularity: Double
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let name: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case id, title
        case overview
        case posterPath = "poster_path"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
    }
}

