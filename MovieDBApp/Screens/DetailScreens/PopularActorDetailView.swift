//
//  PopularActorDetailView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct PopularActorDetailView: View {
    var imageName: String = Constants.mockImage
    var actor: PopularActorModel = .mock
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                ImageLoader(imageURL: imageName).ignoresSafeArea(edges: .top)
                    .frame(height: UIScreen.main.bounds.height / 1.7, alignment: .top)
                    .overlay (
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text(actor.name)
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                                
                                if actor.gender == 1 {
                                    Text("Gender: Female")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal)
                                } else {
                                    Text("Gender: Male")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal)
                                }
                            }
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(maxHeight: 100)
                            .background(
                                LinearGradient(colors: [Color.blackDB.opacity(0.001), Color.blackDB.opacity(1)], startPoint: .top, endPoint: .bottom)
                            )
                        ,alignment: .bottom
                    )
                Text("Known for: ")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.bottom, 2)
                ForEach(actor.knownFor) { movie in
                    Text(movie.originalTitle ?? "")
                }
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
    PopularActorDetailView()
}
