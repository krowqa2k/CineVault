//
//  LatestMovieCell.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import SwiftUI

struct LatestMovieCell: View {
    
    var movie: TrendingMovieModel = .mock
    var imageURL: String = Constants.mockImage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ImageLoader(imageURL: imageURL)
                .frame(width: 140, height: 200)
                .cornerRadius(16)
            
            Text(movie.title)
                .foregroundStyle(.white)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        HStack {
            LatestMovieCell()
            LatestMovieCell()
        }
        .padding()
    }
}
