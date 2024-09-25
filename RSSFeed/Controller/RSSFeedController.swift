//
//  RSSFeedController.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import Combine

class FeedController {
    var feedProviders: CurrentValueSubject<[RSSFeedReponse], Never> = .init([])
}
