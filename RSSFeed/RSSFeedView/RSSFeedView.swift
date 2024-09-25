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
        contentView
            .alert(isPresented: $viewModel.showAlert, error: viewModel.errorMessage) { _ in
                Button("OK") {
                    viewModel.showAlert = false
                }
            } message: { error in
                Text(error.recoverySuggestion ?? "Try again later.")
            }
    }
}

// MARK: - Setup UI
private extension RSSFeedView {
    var contentView: some View {
        NavigationStack {
            listView
                .navigationDestination(for: RSSFeedChildItemsViewModel.self, destination: RSSFeedChildItemsView.init)
                .navigationTitle("Your RSS Feed")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        rightToolbarButton
                    }
                }
                .sheet(isPresented: $viewModel.isSheetPresented) {
                    AddNewFeedView(
                        rssFeedUrl: $viewModel.rssFeedUrl,
                        doneButtonTapped: { url in
                            if let url = url {
                                viewModel.startFeedKit(with: url)
                                viewModel.isSheetPresented = false
                            } else {
                                viewModel.isSheetPresented = false
                            }
                        }
                    )
                }
        }
    }
    
    var listView: some View {
        List($viewModel.feedProviders, id: \.self) { $item in
            ForEach($viewModel.feedProviders) { $provider in
                NavigationLink {
                    RSSFeedChildItemsView(viewModel: RSSFeedChildItemsViewModel(feedTitle: item.title ?? "-", items: item.item))
                } label: {
                    RSSListRowView(
                        title: item.title ?? "-",
                        description: item.description ?? "-",
                        imageUrl: item.imageUrl ?? "-",
                        isFavourite: item.isFavourite,
                        isFavouriteButtonHidden: false,
                        favouriteButtonTapped: { shouldAddToFavourites in
                            item.isFavourite = shouldAddToFavourites
                            viewModel.feedController.addOrUpdateFeed(item)
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
    
    var rightToolbarButton: some View {
        Button(action: {
            viewModel.isSheetPresented = true
        }) {
            Image(systemName: "plus")
        }
    }
}
