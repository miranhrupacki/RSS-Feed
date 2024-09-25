//
//  FeedParserService.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation

class FeedParserService {
    
    func getNewFeed(with url: String, completion: Result<RSSFeedReponse, Error>) {
        guard let feedURL = URL(string: url) else { return }

    }
}
