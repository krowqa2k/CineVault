//
//  UpcomingMovieView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct UpcomingMovieView: View {
    
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                HStack() {
                    Text("Upcoming Movies")
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
                        ForEach(viewModel.upcoming){ upcomingMovie in
                            NavigationLink(destination: UpcomingMovieDetailView(imageName: upcomingMovie.fullPosterPath, movie: upcomingMovie)) {
                                UpcomingMovieCell(movie: upcomingMovie, imageURL: upcomingMovie.fullPosterPath)
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
    UpcomingMovieView()
}
