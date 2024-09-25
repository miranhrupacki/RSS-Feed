//
//  TabBarView.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import SwiftUI

struct TabBarView: View {
    private let viewModelFactory = ViewModelFactory()

    var body: some View {
        TabView {
            RSSFeedView(viewModel: viewModelFactory.makeFeedViewModel())
                .tabItem {
                    Label("Feed", systemImage: "list.dash")
                }
            
            FavouritesFeedView(viewModel: viewModelFactory.makeFavouritesViewModel())
                .tabItem {
                    Label("Favourites", systemImage: "star")
                }
        }
    }
}
