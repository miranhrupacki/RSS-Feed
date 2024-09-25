//
//  FavouritesFeedViewModel.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation

class FavouritesFeedViewModel: ObservableObject {
    @Published var favouriteFeedProviders: [RSSFeedReponse]
    
    var feedController: FeedController

    init(feedController: FeedController) {
        self.feedController = feedController
        
        favouriteFeedProviders = feedController.feedProviders.value
    }
}
