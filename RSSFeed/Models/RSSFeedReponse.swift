//
//  RSSFeedReponse.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation

struct RSSFeedReponse: Decodable, Hashable, Identifiable {
    var id = UUID()
    let title: String?
    let description: String?
    let item: [RSSFeedItemReponse]
    let imageUrl: String?
    var isFavourite: Bool = false
}
