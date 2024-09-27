//
//  FavouritesFeedViewModel.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import Combine

class FavouritesFeedViewModel: ObservableObject {
    @Published var favouriteFeedProviders: [RSSFeedReponse]
    var feedController: FeedController
    private var cancellables = Set<AnyCancellable>()

    init(feedController: FeedController) {
        favouriteFeedProviders = feedController.feedProviders.value
        self.feedController = feedController
        
        feedController.feedProviders.sink { [weak self] in
            self?.favouriteFeedProviders = $0.filter { $0.isFavourite == true }
        }
        .store(in: &cancellables)
    }
}

// MARK: - Update current data
extension FavouritesFeedViewModel {
    func favouriteSelected(_ feed: RSSFeedReponse) {
        feedController.addOrUpdateFeed(feed)
    }
    
    func delete(at offsets: IndexSet) {
        feedController.delete(at: offsets)
    }
    
    func addOrUpdateFeed(_ feed: RSSFeedReponse) {
        feedController.addOrUpdateFeed(feed)
    }
}
