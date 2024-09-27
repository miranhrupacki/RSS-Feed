//
//  RSSListRowView.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import SwiftUI
import Kingfisher

struct RSSListRowView: View {
    let title: String
    let description: String
    let imageUrl: String
    let isFavourite: Bool
    let isFavouriteButtonHidden: Bool
    let favouriteButtonTapped: (() -> Void)
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                favouriteButtonTapped()
            } label: {
                Image(systemName: isFavourite ? "star.fill" : "star")
            }
            .isHidden(isFavouriteButtonHidden, remove: isFavouriteButtonHidden)
            .buttonStyle(PlainButtonStyle())
            
            GeometryReader { geometry in
                KFImage(URL(string: imageUrl))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
            .frame(height: 50)
            .frame(maxWidth: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                Text(description)
                    .font(.caption)
            }
        }
    }
}
