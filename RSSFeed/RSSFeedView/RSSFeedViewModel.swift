//
//  RSSFeedViewModel.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation

class RSSFeedViewModel: ObservableObject {
    @Published var feedProviders: [RSSFeedReponse]

    var feedController: FeedController

    init(feedController: FeedController) {
        self.feedController = feedController
        
        feedProviders = feedController.feedProviders.value
    }
}
