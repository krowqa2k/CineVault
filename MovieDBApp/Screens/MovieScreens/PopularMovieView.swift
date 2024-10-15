//
//  PopularMovieView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct PopularMovieView: View {
    
    @EnvironmentObject var viewModel: MovieDBViewModel
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                HStack() {
                    Text("Popular Movies")
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
                        ForEach(viewModel.popular){ popularMovie in
                            NavigationLink(destination: MovieDetailView(imageName: popularMovie.fullPosterPath, movie: popularMovie)) {
                                MovieCell(movie: popularMovie, imageURL: popularMovie.fullPosterPath)
                            }
                        }
                    }
                }
                .frame(maxHeight: 260)
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    PopularMovieView()
        .environmentObject(MovieDBViewModel())
}
