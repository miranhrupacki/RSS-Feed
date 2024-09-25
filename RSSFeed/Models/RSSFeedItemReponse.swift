//
//  RSSFeedItemReponse.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation

struct RSSFeedItemReponse: Decodable, Hashable {
    var title: String?
    var description: String?
    var pubDate: Date?
    var imageUrl: String?
    var link: String?
}
