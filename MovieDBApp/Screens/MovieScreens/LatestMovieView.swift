//
//  LatestMovieView.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import SwiftUI

struct LatestMovieView: View {
    
    var movie: TrendingMovieModel = .mock
    var imageURL: String = Constants.mockImage
    
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack() {
                        Text("Now Playing")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        })
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(viewModel.trendings){ latestMovie in
                                NavigationLink(destination: NowPlayingDetailView(imageName: latestMovie.fullPosterPath, movie: latestMovie)) {
                                    LatestMovieCell(movie: latestMovie, imageURL: latestMovie.fullPosterPath)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 260)
                    .scrollIndicators(.hidden)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    LatestMovieView(viewModel: MovieDBViewModel())
}
