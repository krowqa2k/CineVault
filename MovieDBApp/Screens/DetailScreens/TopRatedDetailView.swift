//
//  TopRatedDetailView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct TopRatedDetailView: View {
    var imageName: String = Constants.mockImage
    var movie: TopRatedMovieModel = .mock
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                ImageLoader(imageURL: imageName).ignoresSafeArea(edges: .top)
                    .frame(height: UIScreen.main.bounds.height / 1.7, alignment: .top)
                    .overlay (
                        VStack(alignment: .leading) {
                            HStack {
                                Text(movie.adult ? "18+" : "")
                                    .frame(width: 40, height: 40)
                                    .font(.headline)
                                    .foregroundStyle(.blackDB)
                                    .background(movie.adult ? Color.red : .clear)
                                    .cornerRadius(12)
                                Spacer()
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.headline)
                                        .foregroundStyle(.yellow)
                                    Text("\(movie.voteAverage.formatted())")
                                        .font(.headline)
                                        .foregroundStyle(.yellow)
                                }
                                .padding(4)
                                .background(Color.blackDB)
                                .cornerRadius(12)
                            }
                            .padding(.horizontal)
                            
                            Text(movie.title)
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                        }
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: 100)
                            .background(
                                LinearGradient(colors: [Color.blackDB.opacity(0.001), Color.blackDB.opacity(1)], startPoint: .top, endPoint: .bottom)
                            )
                        ,alignment: .bottom
                    )
                Text(movie.overview)
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
            }
            .overlay(
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.blackDB.opacity(0.8))
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                    )
                    .padding()
                    .onTapGesture {
                        dismiss()
                    },alignment: .topLeading
            )
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    TopRatedDetailView()
}
