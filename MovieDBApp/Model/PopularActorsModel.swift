//
//  PopularActorsModel.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import Foundation

struct PopularActorResult: Codable {
    let page: Int
    let results: [PopularActorModel]
}

struct PopularActorModel: Codable, Identifiable {
    let adult: Bool
    let gender, id: Int
    let name, originalName: String
    let popularity: Double
    let profilePath: String
    let knownFor: [KnownFor]

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
    
    var fullPosterPath: String {
            Constants.imageGet + profilePath
        }
}

struct KnownFor: Codable, Identifiable {
    let id: Int
    let title, originalTitle: String?
    let overview, posterPath: String
    let adult: Bool
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let name, originalName, firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case adult
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
    }
    
    var fullPosterPath: String {
            Constants.imageGet + posterPath
        }
}


