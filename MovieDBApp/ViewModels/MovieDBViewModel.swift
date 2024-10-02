//
//  MovieDBViewModel.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import Foundation

@MainActor
final class MovieDBViewModel: ObservableObject {
    private let favoritesManager = FavoritesManager()
    private let webService = WebService()
    
    @Published private(set) var trendings: [MovieModel] = []
    @Published private(set) var popular: [MovieModel] = []
    @Published private(set) var popularActor: [ActorModel] = []
    @Published private(set) var airingToday: [SeriesModel] = []
    @Published private(set) var popularSeries: [SeriesModel] = []
    @Published private(set) var onTheAirSeries: [SeriesModel] = []
    @Published private(set) var searchDB: [SearchDBModel] = []
    @Published private(set) var topRatedSeries: [SeriesModel] = []
    @Published private(set) var upcoming: [MovieModel] = []
    @Published private(set) var topRated: [MovieModel] = []
    
    @Published var favoriteMoviesAndSeries: Set<String> {
        didSet {
            favoritesManager.favoriteMoviesAndSeries = favoriteMoviesAndSeries
        }
    }
    
    init() {
        self.favoriteMoviesAndSeries = favoritesManager.favoriteMoviesAndSeries
    }
    
    func addFavorite(posterPath: String) {
        Task { @MainActor in
            self.favoriteMoviesAndSeries.insert(posterPath)
        }
    }

    func removeFavorite(posterPath: String) {
        Task { @MainActor in
            self.favoriteMoviesAndSeries.remove(posterPath)
        }
    }
    
    func sortUpcomingMoviesByDate() {
        Task { @MainActor in
            let sortedUpcoming = self.upcoming.sorted { $1.releaseDate > $0.releaseDate }
            self.upcoming = sortedUpcoming
        }
    }
    
    func sortTopRatedMoviesByRating() {
        Task { @MainActor in
            let sortedTopRated = self.topRated.sorted { $0.voteAverage > $1.voteAverage }
            self.topRated = sortedTopRated
        }
    }
    
    func sortTopRatedSeriesByRating() {
        Task { @MainActor in
            let sortedTopRatedSeries = self.topRatedSeries.sorted { $0.voteAverage ?? 0 > $1.voteAverage ?? 0 }
            self.topRatedSeries = sortedTopRatedSeries
        }
    }
    
    func getYear(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        } else {
            return ""
        }
    }
    
    private func updateData<T: Decodable>(fetch: @escaping () async throws -> T, update: @escaping (T) -> Void) {
        Task {
            do {
                let result = try await fetch()
                await MainActor.run {
                    update(result)
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func getTrendingsData() {
        updateData(fetch: webService.getTrendingsData) { [weak self] (result: MovieResults) in
            self?.trendings = result.results
        }
    }
    
    func getPopularData() {
        updateData(fetch: webService.getPopularData) { [weak self] (result: MovieResults) in
            self?.popular = result.results
        }
    }
    
    func getUpcomingData() {
        updateData(fetch: webService.getUpcomingData) { [weak self] (result: MovieResults) in
            self?.upcoming = result.results
            self?.sortUpcomingMoviesByDate()
        }
    }
    
    func getTopRatedData() {
        updateData(fetch: webService.getTopRatedData) { [weak self] (result: MovieResults) in
            self?.topRated = result.results
            self?.sortTopRatedMoviesByRating()
        }
    }
    
    func getPopularActorData() {
        updateData(fetch: webService.getPopularActorData) { [weak self] (result: ActorResults) in
            self?.popularActor = result.results
        }
    }
    
    func getAiringTodayData() {
        updateData(fetch: webService.getAiringTodayData) { [weak self] (result: SeriesResults) in
            self?.airingToday = result.results
        }
    }
    
    func getPopularSeriesData() {
        updateData(fetch: webService.getPopularSeriesData) { [weak self] (result: SeriesResults) in
            self?.popularSeries = result.results
        }
    }
    
    func getTopRatedSeriesData() {
        updateData(fetch: webService.getTopRatedSeriesData) { [weak self] (result: SeriesResults) in
            self?.topRatedSeries = result.results
            self?.sortTopRatedSeriesByRating()
        }
    }
    
    func getOnTheAirSeriesData() {
        updateData(fetch: webService.getOnTheAirSeriesData) { [weak self] (result: SeriesResults) in
            self?.onTheAirSeries = result.results
        }
    }
    
    func getSearchDBData(query: String) {
        Task {
            do {
                let result = try await webService.getSearchDBData(query: query)
                await MainActor.run {
                    self.searchDB = result.results
                }
            } catch {
                print("Error fetching search data: \(error)")
            }
        }
    }
}
