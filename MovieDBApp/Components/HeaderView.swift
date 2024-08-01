//
//  HeaderView.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import SwiftUI

struct HeaderView: View {
    
    @State var userName: String = "Mateusz"
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome 👋")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                    if userName.isEmpty {
                        Text("")
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                    }
                    Text("\(userName)")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                }
                Spacer()
                Image(systemName: "popcorn.fill")
                    .font(.system(size: 25))
                    .foregroundStyle(.white)
            }
            .padding()
            
            HStack {
                VStack {
                    
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        HeaderView()
    }
}
