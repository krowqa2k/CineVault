//
//  TopRatedMovieView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct TopRatedMovieView: View {
    
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                HStack() {
                    Text("Top Rated Movies")
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
                        ForEach(viewModel.topRated){ topRatedMovie in
                            NavigationLink(destination: TopRatedDetailView(imageName: topRatedMovie.fullPosterPath, movie: topRatedMovie)) {
                                TopRatedMovieCell(movie: topRatedMovie, imageURL: topRatedMovie.fullPosterPath)
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
    TopRatedMovieView()
}