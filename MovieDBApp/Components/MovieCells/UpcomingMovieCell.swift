//
//  UpcomingMovieCell.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct UpcomingMovieCell: View {
    var movie: UpcomingMovieModel = .mock
    var imageURL: String = Constants.mockImage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ImageLoader(imageURL: imageURL)
                .frame(width: 160, height: 220)
                .cornerRadius(16)
            
            Text(movie.title)
                .foregroundStyle(.white)
                .font(.caption)
                .fontWeight(.semibold)
                .lineLimit(2)
                .frame(width: 160)
        }
        .padding(.leading, 8)
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        HStack {
            UpcomingMovieCell()
            UpcomingMovieCell()
        }
        .padding()
    }
}