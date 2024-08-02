//
//  TopRatedMovieListCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct TopRatedMovieListCell: View {
    var imageName: String = Constants.mockImage
    var movie: TopRatedMovieModel = .mock
    
    var body: some View {
        HStack(spacing: 12) {
            ImageLoader(imageURL: imageName)
                .frame(width: 110, height: 160)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 8){
                Text(movie.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text("Release date: \(movie.releaseDate)")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                HStack {
                    Image(systemName: "star.fill")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text("\(movie.voteAverage.formatted())")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                }
            }
            .frame(maxHeight: 150, alignment: .top)
        }
    }
}

#Preview {
    TopRatedMovieListCell()
}
