//
//  PopularSeriesModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import Foundation

struct PopularSeriesResults: Codable {
    let page: Int
    let results: [PopularSeriesModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PopularSeriesModel: Codable, Identifiable {
    let adult: Bool
    let id: Int
    let originalLanguage, overview: String
    let posterPath, name: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case name
        case voteAverage = "vote_average"
    }
}
