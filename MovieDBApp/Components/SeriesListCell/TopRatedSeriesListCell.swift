//
//  TopRatedSeriesListCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct TopRatedSeriesListCell: View {
    var imageName: String = Constants.mockImage
    var series: SeriesModel = .mock
    
    var body: some View {
        HStack(spacing: 12) {
            ImageLoader(imageURL: imageName)
                .frame(width: 110, height: 160)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 8){
                Text(series.name ?? "")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                if let adult = series.adult {
                    if adult {
                        Text("For adults")
                            .font(.system(size: 13))
                            .foregroundStyle(.red)
                    }
                }
                HStack {
                    Image(systemName: "star.fill")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", series.voteAverage ?? ""))
                        .font(.headline)
                        .foregroundStyle(.yellow)
                }
            }
            .frame(maxHeight: 150, alignment: .top)
        }
    }
}

#Preview {
    TopRatedSeriesListCell()
}
