//
//  FeedParserService.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import FeedKit

class FeedParserService {
    func getNewFeed(with url: String, completion: @escaping (Result<RSSFeedReponse, ParserError>) -> Void) {
        guard let feedURL = URL(string: url) else { return }
        let parser = FeedParser(URL: feedURL)

        parser.parseAsync(queue: .global(qos: .background)) { [weak self] (result) in
           guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let feed):
                    switch feed {
                    case let .atom(feed):
                        let feedChildItems = self.atomDataMapper(feedItems: feed.entries ?? [])
                        let mainFeedModel = RSSFeedReponse(
                            title: feed.title,
                            description: feed.subtitle?.value,
                            item: feedChildItems,
                            imageUrl: feed.logo
                        )
                        
                        completion(.success(mainFeedModel))
                    case let .rss(feed):
                        let feedChildItems = self.rssDataMapper(feedItems: feed.items ?? [])
                        let mainFeedModel = RSSFeedReponse(
                            title: feed.title,
                            description: feed.description,
                            item: feedChildItems,
                            imageUrl: feed.image?.url
                        )
                        
                        completion(.success(mainFeedModel))
                    case let .json(feed):
                        let feedChildItems = self.jsonDataMapper(feedItems: feed.items ?? [])
                        let mainFeedModel = RSSFeedReponse(
                            title: feed.title,
                            description: feed.description,
                            item: feedChildItems, 
                            imageUrl: feed.icon
                        )
                        
                        completion(.success(mainFeedModel))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
       }
    }
}

// MARK: - Data mapping
extension FeedParserService {
    func atomDataMapper(feedItems: [AtomFeedEntry]) -> [RSSFeedItemReponse] {
        return feedItems.compactMap { singleItem in
            RSSFeedItemReponse(title: singleItem.title, description: singleItem.summary?.value, pubDate: singleItem.updated, link: singleItem.links?.first?.attributes?.href)
        }
    }
    
    func rssDataMapper(feedItems: [RSSFeedItem]) -> [RSSFeedItemReponse] {
        return feedItems.compactMap { singleItem in
            RSSFeedItemReponse(title: singleItem.title, description: singleItem.description, pubDate: singleItem.pubDate, link: singleItem.link)
        }
    }
    
    func jsonDataMapper(feedItems: [JSONFeedItem]) -> [RSSFeedItemReponse] {
        return feedItems.compactMap { singleItem in
            RSSFeedItemReponse(title: singleItem.title, description: singleItem.summary, pubDate: singleItem.datePublished, link: singleItem.url)
        }
    }
}
