//
//  RSSFeedChildItemsView.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import SwiftUI

struct RSSFeedChildItemsView: View {
    var viewModel: RSSFeedChildItemsViewModel

    var body: some View {
        List(viewModel.items, id: \.self) { item in
            NavigationLink {
                Color.red
            } label: {
                RSSListRowView(title: item.title ?? "-",
                               description: item.description ?? "-",
                               imageUrl: item.imageUrl ?? "-")
            }
        }
        .navigationTitle(viewModel.feedTitle)
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
    }
}
