//
//  MovieDBViewModel.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import Foundation

class MovieDBViewModel: ObservableObject {
    private let favoritesManager = FavoritesManager()
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
    
    static let api_key: String = "5c7cea308def9c5b381b8e963b9df62a"
    private let queue = DispatchQueue(label: "com.moviedbapp.apiqueue", qos: .background, attributes: .concurrent)
    
    init() {
        self.favoriteMoviesAndSeries = favoritesManager.favoriteMoviesAndSeries
        loadInitialData()
    }
    
    private func loadInitialData() {
        queue.async { [weak self] in
            self?.getTrendingsData()
            self?.getPopularData()
            self?.getUpcomingData()
            self?.getTopRatedData()
            self?.getPopularActorData()
            self?.getAiringTodayData()
            self?.getPopularSeriesData()
            self?.getTopRatedSeriesData()
            self?.getOnTheAirSeriesData()
        }
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
    
    private func performAPICall<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode,
                  error == nil else {
                print("API call failed: \(url)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print("Decoding error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func getTrendingsData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(MovieDBViewModel.api_key)") else { return }
        performAPICall(url: url) { [weak self] (result: TrendingResults?) in
            self?.trendings = result?.results ?? []
        }
    }
    
    func getPopularData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(MovieDBViewModel.api_key)") else { return }
        performAPICall(url: url) { [weak self] (result: PopularMovieResults?) in
            self?.popular = result?.results ?? []
        }
    }
    
    func getUpcomingData() {
        guard var components = URLComponents(string: "https://api.themoviedb.org/3/movie/upcoming") else { return }
        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieDBViewModel.api_key),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: "US")
        ]
        guard let url = components.url else { return }
        
        performAPICall(url: url) { [weak self] (result: UpcomingResults?) in
            self?.upcoming = result?.results ?? []
            self?.sortUpcomingMoviesByDate()
        }
    }
    
    func getTopRatedData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(MovieDBViewModel.api_key)") else { return }
        performAPICall(url: url) { [weak self] (result: TopRatedResults?) in
            self?.topRated = result?.results ?? []
            self?.sortTopRatedMoviesByRating()
        }
    }
    
    func getPopularActorData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=\(MovieDBViewModel.api_key)") else { return }
        performAPICall(url: url) { [weak self] (result: PopularActorResult?) in
            self?.popularActor = result?.results ?? []
        }
    }
    
    func getAiringTodayData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/airing_today?api_key=\(MovieDBViewModel.api_key)") else { return }
        performAPICall(url: url) { [weak self] (result: AiringTodayResult?) in
            self?.airingToday = result?.results ?? []
        }
    }
    
    func getPopularSeriesData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/tv/day?api_key=\(MovieDBViewModel.api_key)") else { return }
        performAPICall(url: url) { [weak self] (result: PopularSeriesResults?) in
            self?.popularSeries = result?.results ?? []
        }
    }
    
    func getTopRatedSeriesData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=\(MovieDBViewModel.api_key)") else { return }
        performAPICall(url: url) { [weak self] (result: TopRatedSeriesResults?) in
            self?.topRatedSeries = result?.results ?? []
            self?.sortTopRatedSeriesByRating()
        }
    }
    
    func getOnTheAirSeriesData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(MovieDBViewModel.api_key)") else { return }
        performAPICall(url: url) { [weak self] (result: OnTheAirSeriesResults?) in
            self?.onTheAirSeries = result?.results ?? []
        }
    }
    
    func getSearchDBData(query: String) {
        guard !query.isEmpty else { return }
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://api.themoviedb.org/3/search/multi?api_key=\(MovieDBViewModel.api_key)&query=\(queryEncoded)") else { return }
        performAPICall(url: url) { [weak self] (result: SearchDBResults?) in
            self?.searchDB = result?.results ?? []
        }
    }
}
