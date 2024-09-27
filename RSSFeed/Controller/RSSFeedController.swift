//
//  RSSFeedController.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import Combine
import FeedKit

class FeedController: ObservableObject, FeedControllerProtocol {
    var feedProviders: CurrentValueSubject<[RSSFeedReponse], Never> = .init([])
    var errorMessage: CurrentValueSubject<ParserError?, Never> = .init(nil)
    var showAlert: CurrentValueSubject<Bool, Never> = .init(false)
    var feedService = FeedParserService()
}

// MARK: - Data parser
extension FeedController {
    func startFeedKit(with url: String) {
        feedService.getNewFeed(with: url) { [weak self] result in
            switch result {
            case .success(let response):
                self?.addOrUpdateFeed(response)
            case .failure(let error):
                self?.showAlert.value = true
                self?.errorMessage.value = error
            }
        }
    }
}

// MARK: - Update current data
extension FeedController {
    func favouriteSelected(_ feed: RSSFeedReponse) {
        let newFeed = RSSFeedReponse(id: feed.id, title: feed.title, description: feed.description, item: feed.item, imageUrl: feed.imageUrl, isFavourite: !feed.isFavourite)
        
        addOrUpdateFeed(newFeed)
    }
    
    func addOrUpdateFeed(_ feed: RSSFeedReponse) {
        if let index = feedProviders.value.firstIndex(where: { $0.id == feed.id }) {
            feedProviders.value[index] = feed
        } else {
            feedProviders.value.append(feed)
        }
    }
    
    func delete(at offsets: IndexSet) {
        feedProviders.value.remove(atOffsets: offsets)
    }
    
    func delete(_ feed: RSSFeedReponse) {
        if let index = feedProviders.value.firstIndex(where: { $0.id == feed.id }) {
            feedProviders.value.remove(at: index)
        }
    }
}
