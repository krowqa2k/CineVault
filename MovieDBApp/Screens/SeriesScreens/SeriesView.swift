//
//  LatestSeriesView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct AiringTodaySeriesView: View {
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        SeriesListView(
            title: "New Episode Today!",
            viewAllDestination: AiringTodayListView(),
            series: viewModel.airingToday,
            getSeriesData: {
                viewModel.getAiringTodayData()
            }
        )
    }
}

struct PopularSeriesView: View {
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        SeriesListView(
            title: "Popular Series",
            viewAllDestination: PopularSeriesListView(),
            series: viewModel.popularSeries,
            getSeriesData: {
                viewModel.getPopularSeriesData()
            }
        )
    }
}

struct TopRatesSeriesView: View {
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        SeriesListView(
            title: "Top Rated Series",
            viewAllDestination: <#T##View#>,
            series: <#T##[SeriesModel]#>,
            getSeriesData: <#T##() -> Void#>
        )
    }
}

