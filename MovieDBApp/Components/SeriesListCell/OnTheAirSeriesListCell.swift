//
//  OnTheAirSeriesListCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct OnTheAirSeriesListCell: View {
    var imageName: String = Constants.mockImage
    var series: OnTheAirSeriesModel = .mock
    
    var body: some View {
        HStack(spacing: 12) {
            ImageLoader(imageURL: imageName)
                .frame(width: 110, height: 160)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 8){
                Text(series.name)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                Text("Original Language: \(series.originalLanguage)")
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
                if series.adult {
                    Text("For adults")
                        .font(.system(size: 13))
                        .foregroundStyle(.red)
                }
                HStack {
                    Image(systemName: "star.fill")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", series.voteAverage))
                        .font(.headline)
                        .foregroundStyle(.yellow)
                }
            }
            .frame(maxHeight: 150, alignment: .top)
        }
    }
}

#Preview {
    OnTheAirSeriesListCell()
}
