//
//  FavouritesFeedViewModel.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation

class FavouritesFeedViewModel: ObservableObject {
    var feedController: FeedController

    init(feedController: FeedController) {
        self.feedController = feedController
    }
}
