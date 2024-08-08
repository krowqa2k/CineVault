//
//  AiringTodaySeriesDetailView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct AiringTodaySeriesDetailView: View {
    var imageName: String = Constants.mockImage
    var series: AiringTodayModel = .mock
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
                                if let seriesAdult = series.adult {
                                    Text(seriesAdult ? "18+" : "")
                                        .frame(width: 40, height: 40)
                                        .font(.headline)
                                        .foregroundStyle(.blackDB)
                                        .background(seriesAdult ? Color.red : .clear)
                                        .cornerRadius(12)
                                }
    
                                Spacer()
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.headline)
                                        .foregroundStyle(.yellow)
                                    Text(String(format: "%.2f", series.voteAverage ?? ""))
                                        .font(.headline)
                                        .foregroundStyle(.yellow)
                                }
                                .padding(4)
                                .background(Color.blackDB)
                                .cornerRadius(12)
                            }
                            .padding(.horizontal)
                            
                            Text(series.name ?? "")
                                .font(.system(size: 26))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            Text("Release Date: \(series.firstAirDate ?? "")")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                        }
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: 100)
                            .padding(.bottom)
                            .background(
                                LinearGradient(colors: [Color.blackDB.opacity(0.001), Color.blackDB.opacity(1)], startPoint: .top, endPoint: .bottom)
                            )
                        ,alignment: .bottom
                    )
                ScrollView(.vertical){
                    Text(series.overview ?? "")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                }
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
    AiringTodaySeriesDetailView()
}
