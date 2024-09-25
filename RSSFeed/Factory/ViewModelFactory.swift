//
//  ViewModelFactory.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import SwiftUI

class ViewModelFactory: ObservableObject {
    let feedController = FeedController()
    
    func makeFeedViewModel() -> RSSFeedViewModel {
        return RSSFeedViewModel(feedController: feedController)
    }
    
    func makeFavouritesViewModel() -> FavouritesFeedViewModel {
        return FavouritesFeedViewModel(feedController: feedController)
    }
}
