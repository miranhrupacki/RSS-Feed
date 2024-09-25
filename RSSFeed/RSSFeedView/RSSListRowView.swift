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
    var title: String
    var description: String
    var imageUrl: String

    var body: some View {
        HStack(spacing: 20) {
            Button {
                print("button tapped")
            } label: {
                Image(systemName: "star.fill")
            }
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
