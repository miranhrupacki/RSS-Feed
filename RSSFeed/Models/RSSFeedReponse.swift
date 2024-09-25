//
//  RSSFeedReponse.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation

struct RSSFeedReponse: Decodable, Hashable, Identifiable {
    let id = UUID()
    var title: String?
    var description: String?
    var item: [RSSFeedItemReponse]
    var imageUrl: String?
    var isFavourite: Bool = false
}
