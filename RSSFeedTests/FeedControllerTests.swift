//
//  RSSFeedTests.swift
//  RSSFeedTests
//
//  Created by Miran Hrupački on 25.09.2024..
//

import XCTest
@testable import RSSFeed

final class RSSFeedTests: XCTestCase {
    var feedController: FeedController!
    
    override func setUp() {
        super.setUp()
        feedController = FeedController()
    }
    
    override func tearDown() {
        feedController = nil
        super.tearDown()
    }
    
    func test_isDataEmpty() {
        XCTAssertEqual(feedController.feedProviders.value, [])
    }
    
    func test_isFeedAdded() {
        let feed = RSSFeedReponse(
            title: "Test title",
            description: "Some test description",
            item: [
                RSSFeedItemReponse(
                    title: "Some child test title",
                    description: "Some child test description",
                    imageUrl: "Some child test image url"
                )
            ],
            imageUrl: "Some test image url"
        )
        feedController.addOrUpdateFeed(feed)
        XCTAssertNotEqual(feedController.feedProviders.value, [], "Feed providers are empty")
    }
    
    func test_isErrorNil() {
        XCTAssertNil(feedController.errorMessage.value, "Error message is not nil")
    }
    
    func test_isShouldShowAlertFalse() {
        XCTAssertFalse(feedController.showAlert.value, "Should show alert is not equal to false")
    }
    
    func test_deleteFeedByIndex() {
        let feed = RSSFeedReponse(
            title: "Test title",
            description: "Some test description",
            item: [
                RSSFeedItemReponse(
                    title: "Some child test title",
                    description: "Some child test description",
                    imageUrl: "Some child test image url"
                )
            ],
            imageUrl: "Some test image url"
        )
        feedController.addOrUpdateFeed(feed)
        
        feedController.delete(at: IndexSet(integer: 0))
        
        XCTAssertEqual(feedController.feedProviders.value, [])
    }
    
    func test_deleteFeed() {
        let feed = RSSFeedReponse(
            title: "Test title",
            description: "Some test description",
            item: [
                RSSFeedItemReponse(
                    title: "Some child test title",
                    description: "Some child test description",
                    imageUrl: "Some child test image url"
                )
            ],
            imageUrl: "Some test image url"
        )
        feedController.addOrUpdateFeed(feed)
        
        feedController.delete(feed)
        
        XCTAssertEqual(feedController.feedProviders.value, [])
    }
    
    func test_deleteFeedByIndexWhenEmpty() {
        feedController.delete(at: IndexSet(integer: 0))

        XCTAssertEqual(feedController.feedProviders.value, [])
    }
    
    func test_deleteFeedWhenEmpty() {
        let feed = RSSFeedReponse(
            title: "Test title",
            description: "Some test description",
            item: [
                RSSFeedItemReponse(
                    title: "Some child test title",
                    description: "Some child test description",
                    imageUrl: "Some child test image url"
                )
            ],
            imageUrl: "Some test image url"
        )
        
        feedController.delete(feed)
        
        XCTAssertEqual(feedController.feedProviders.value, [])
    }
}

import Combine
import FeedKit

class FeedControllerMock: FeedControllerProtocol {
    var feedProviders: CurrentValueSubject<[RSSFeedReponse], Never> = .init([])
    var errorMessage: CurrentValueSubject<ParserError?, Never> = .init(nil)
    var showAlert: CurrentValueSubject<Bool, Never> = .init(false)
    var feedService = FeedParserService()
    
    func startFeedKit(with url: String) {
        
    }
    
    func favouriteSelected(_ feed: RSSFeedReponse) {
        
    }
    
    func addOrUpdateFeed(_ feed: RSSFeedReponse) {
        
    }
    
    func delete(at offsets: IndexSet) {
        
    }
    
    func delete(_ feed: RSSFeedReponse) {
        
    }
}
