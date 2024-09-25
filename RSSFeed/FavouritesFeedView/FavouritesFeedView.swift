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
        List($viewModel.favouriteFeedProviders, id: \.id) { $item in
            ForEach($viewModel.favouriteFeedProviders) { $provider in
                NavigationLink {
                    RSSFeedChildItemsView(viewModel: RSSFeedChildItemsViewModel(feedTitle: item.title ?? "-", items: item.item))
                } label: {
                    RSSListRowView(title: item.title ?? "-",
                                              description: item.description ?? "-",
                                              imageUrl: item.imageUrl ?? "-",
                                              isFavourite: item.isFavourite,
                                              isFavouriteButtonHidden: false,
                                              favouriteButtonTapped: { shouldAddToFavourites in
                        item.isFavourite = shouldAddToFavourites
                        viewModel.feedController.addOrUpdateFeed(item)
                    })
                }
            }
            .onDelete(perform: viewModel.delete)
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
