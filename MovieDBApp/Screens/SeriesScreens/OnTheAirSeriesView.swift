//
//  TrendingSeriesView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct OnTheAirSeriesView: View {
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack() {
                        Text("On Air Currently")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        NavigationLink(destination: PopularMovieListView()) {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(viewModel.onTheAirSeries){ onAirSeries in
                                NavigationLink(destination: OnTheAirSeriesDetailView(imageName: onAirSeries.fullPosterPath, movie: onAirSeries)) {
                                    OnTheAirSeriesCell(movie: onAirSeries, imageURL: onAirSeries.fullPosterPath)
                                }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 280)
                    .scrollIndicators(.hidden)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
}

#Preview {
    OnTheAirSeriesView()
}
