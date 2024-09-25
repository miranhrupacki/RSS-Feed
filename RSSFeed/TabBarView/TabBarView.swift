//
//  TabBarView.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            RSSFeedView()
                .tabItem {
                    Label("Feed", systemImage: "list.dash")
                }
            
            FavouritesFeedView()
                .tabItem {
                    Label("Favourites", systemImage: "star")
                }
        }
    }
}
