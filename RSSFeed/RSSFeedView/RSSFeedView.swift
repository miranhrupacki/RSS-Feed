//
//  RSSFeedView.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import SwiftUI

struct RSSFeedView: View {
    @ObservedObject var viewModel: RSSFeedViewModel

    var body: some View {
        List($viewModel.feedProviders, id: \.self) { $item in
            ForEach($viewModel.feedProviders) { $provider in
                NavigationLink {
                    RSSFeedChildItemsView(viewModel: RSSFeedChildItemsViewModel(feedTitle: item.title ?? "-", items: item.item))
                } label: {
                    RSSListRowView(title: item.title ?? "-",
                                   description: item.description ?? "-",
                                   imageUrl: item.imageUrl ?? "-")
                }
            }
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
