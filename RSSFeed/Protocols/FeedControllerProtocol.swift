//
//  FeedControllerProtocol.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 27.09.2024..
//

import Foundation
import Combine
import FeedKit

protocol FeedControllerProtocol {
    var feedProviders: CurrentValueSubject<[RSSFeedReponse], Never> { get set }
    var errorMessage: CurrentValueSubject<ParserError?, Never> { get set }
    var showAlert: CurrentValueSubject<Bool, Never> { get set }
    var feedService: FeedParserService { get set }
    
    func startFeedKit(with url: String)
    func favouriteSelected(_ feed: RSSFeedReponse)
    func addOrUpdateFeed(_ feed: RSSFeedReponse)
    func delete(at offsets: IndexSet)
    func delete(_ feed: RSSFeedReponse)
}
