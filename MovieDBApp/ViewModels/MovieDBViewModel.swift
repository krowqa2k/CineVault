//
//  MovieDBViewModel.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import Foundation

class MovieDBViewModel: ObservableObject {
    private let favoritesManager = FavoritesManager()
    private let webService = WebService()
    
    @Published private(set) var trendings: [TrendingMovieModel] = []
    @Published private(set) var popular: [PopularMovieModel] = []
    @Published private(set) var popularActor: [PopularActorModel] = []
    @Published private(set) var airingToday: [AiringTodayModel] = []
    @Published private(set) var popularSeries: [PopularSeriesModel] = []
    @Published private(set) var onTheAirSeries: [OnTheAirSeriesModel] = []
    @Published private(set) var searchDB: [SearchDBModel] = []
    @Published private(set) var topRatedSeries: [TopRatedSeriesModel] = []
    @Published private(set) var upcoming: [UpcomingMovieModel] = []
    @Published private(set) var topRated: [TopRatedMovieModel] = []
    
    @Published var favoriteMoviesAndSeries: Set<String> {
        didSet {
            favoritesManager.favoriteMoviesAndSeries = favoriteMoviesAndSeries
        }
    }
    
    init() {
        self.favoriteMoviesAndSeries = favoritesManager.favoriteMoviesAndSeries
    }
    
    
    func addFavorite(posterPath: String) {
        DispatchQueue.main.async {
            self.favoriteMoviesAndSeries.insert(posterPath)
        }
    }

    func removeFavorite(posterPath: String) {
        DispatchQueue.main.async {
            self.favoriteMoviesAndSeries.remove(posterPath)
        }
    }
    
    func sortUpcomingMoviesByDate() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let sortedUpcoming = self.upcoming.sorted { $1.releaseDate > $0.releaseDate }
            DispatchQueue.main.async {
                self.upcoming = sortedUpcoming
            }
        }
    }
    
    func sortTopRatedMoviesByRating() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let sortedTopRated = self.topRated.sorted { $0.voteAverage > $1.voteAverage }
            DispatchQueue.main.async {
                self.topRated = sortedTopRated
            }
        }
    }
    
    func sortTopRatedSeriesByRating() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let sortedTopRatedSeries = self.topRatedSeries.sorted { $0.voteAverage > $1.voteAverage }
            DispatchQueue.main.async {
                self.topRatedSeries = sortedTopRatedSeries
            }
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
                update(result)
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func getTrendingsData() {
        updateData(fetch: webService.getTrendingsData) { [weak self] (result: TrendingResults) in
            self?.trendings = result.results
        }
    }
    
    func getPopularData() {
        updateData(fetch: webService.getPopularData) { [weak self] (result: PopularMovieResults) in
            self?.popular = result.results
        }
    }
    
    func getUpcomingData() {
        updateData(fetch: webService.getUpcomingData) { [weak self] (result: UpcomingResults) in
            self?.upcoming = result.results
            self?.sortUpcomingMoviesByDate()
        }
    }
    
    func getTopRatedData() {
        updateData(fetch: webService.getTopRatedData) { [weak self] (result: TopRatedResults) in
            self?.topRated = result.results
            self?.sortTopRatedMoviesByRating()
        }
    }
    
    func getPopularActorData() {
        updateData(fetch: webService.getPopularActorData) { [weak self] (result: PopularActorResult) in
            self?.popularActor = result.results
        }
    }
    
    func getAiringTodayData() {
        updateData(fetch: webService.getAiringTodayData) { [weak self] (result: AiringTodayResult) in
            self?.airingToday = result.results
        }
    }
    
    func getPopularSeriesData() {
        updateData(fetch: webService.getPopularSeriesData) { [weak self] (result: PopularSeriesResults) in
            self?.popularSeries = result.results
        }
    }
    
    func getTopRatedSeriesData() {
        updateData(fetch: webService.getTopRatedSeriesData) { [weak self] (result: TopRatedSeriesResults) in
            self?.topRatedSeries = result.results
            self?.sortTopRatedSeriesByRating()
        }
    }
    
    func getOnTheAirSeriesData() {
        updateData(fetch: webService.getOnTheAirSeriesData) { [weak self] (result: OnTheAirSeriesResults) in
            self?.onTheAirSeries = result.results
        }
    }
    
    func getSearchDBData(query: String) {
        Task {
            do {
                let result = try await webService.getSearchDBData(query: query)
                DispatchQueue.main.async {
                    self.searchDB = result.results
                }
            } catch {
                print("Error fetching search data: \(error)")
            }
        }
    }
}
