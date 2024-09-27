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
                                viewModel.rssFeedUrl = ""
                            } else {
                                viewModel.isSheetPresented = false
                                viewModel.rssFeedUrl = ""
                            }
                        }
                    )
                }
        }
    }
    
    var listView: some View {
        List {
            ForEach(viewModel.feedProviders) { provider in
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
    
    var rightToolbarButton: some View {
        Button(action: {
            viewModel.isSheetPresented = true
        }) {
            Image(systemName: "plus")
        }
    }
}
