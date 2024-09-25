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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
