//
//  FavouritesFeedView.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import SwiftUI

struct FavouritesFeedView: View {
    @ObservedObject var viewModel: FavouritesFeedViewModel

    var body: some View {
        contentView
    }
}

// MARK: - Setup UI
private extension FavouritesFeedView {
    var contentView: some View {
        NavigationStack {
            if viewModel.favouriteFeedProviders.isEmpty {
                Text("Your favourite list is empty.")
            } else {
                listView
                    .navigationDestination(for: RSSFeedChildItemsViewModel.self, destination: RSSFeedChildItemsView.init)
                    .navigationTitle("Favourite feeds")
            }
        }
    }
    
    var listView: some View {
        List {
            ForEach(viewModel.favouriteFeedProviders) { provider in
                NavigationLink {
                    RSSFeedChildItemsView(viewModel: RSSFeedChildItemsViewModel(feedTitle: provider.title ?? "-", items: provider.item))
                } label: {
                    RSSListRowView(
                        title: provider.title ?? "-",
                        description: provider.description ?? "-",
                        imageUrl: provider.imageUrl ?? "-",
                        isFavourite: provider.isFavourite,
                        isFavouriteButtonHidden: false,
                        favouriteButtonTapped: {
                            viewModel.favouriteSelected(provider)
                        }
                    )
                }
            }
            .onDelete(perform: viewModel.delete)
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
