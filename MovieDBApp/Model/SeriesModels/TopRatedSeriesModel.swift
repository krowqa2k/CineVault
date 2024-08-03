//
//  TopRatedSeriesModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import Foundation

struct TopRatedSeriesResults: Codable {
    let page: Int
    let results: [TopRatedSeriesModel]
}

struct TopRatedSeriesModel: Codable, Identifiable {
    let adult: Bool
    let id: Int
    let overview: String
    let posterPath: String?
    let name: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case overview
        case posterPath = "poster_path"
        case name
        case voteAverage = "vote_average"
    }
    
    var fullPosterPath: String {
        guard let posterPath = posterPath else { return Constants.noImage }
        return Constants.imageGet + posterPath
    }
    
    static var mock: TopRatedSeriesModel {
        TopRatedSeriesModel(
            adult: false,
            id: 12345,
            overview: "bald guy doing meth",
            posterPath: "some poster path",
            name: "Breaking Bad",
            voteAverage: 8.626
        )
    }
}


