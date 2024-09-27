//
//  RSSFeedViewModelTests.swift
//  RSSFeedTests
//
//  Created by Miran Hrupački on 27.09.2024..
//

import XCTest
import Combine
import FeedKit
@testable import RSSFeed

final class RSSFeedViewModelTests: XCTestCase {
    var feedController: FeedControllerMock!

    override func setUp() {
        super.setUp()
        feedController = FeedControllerMock()
    }
    
    override func tearDown() {
        feedController = nil
        super.tearDown()
    }
    
    func test_startFeedKit() {
        feedController.startFeedKit(with: "Some test url")
        XCTAssertTrue(feedController.didCallStartFeedKit)
    }
    
    func test_favouriteSelected() {
        let feed = RSSFeedReponse(title: "Test description", description: "Test description", item: [RSSFeedItemReponse()], imageUrl: "Test image url")
        feedController.favouriteSelected(feed)
        XCTAssertTrue(feedController.didCallFavouriteSelected)
    }
    
    func test_addOrUpdateFeed() {
        let feed = RSSFeedReponse(title: "Test description", description: "Test description", item: [RSSFeedItemReponse()], imageUrl: "Test image url")
        feedController.addOrUpdateFeed(feed)
        XCTAssertTrue(feedController.didCallAddOrUpdate)
    }
    
    func test_delete() {
        feedController.delete(at: IndexSet(integer: 0))
        XCTAssertTrue(feedController.didCallDeleteAtOffset)
    }
    
    func test_deleteFeed() {
        let feed = RSSFeedReponse(title: "Test description", description: "Test description", item: [RSSFeedItemReponse()], imageUrl: "Test image url")
        feedController.delete(feed)
        XCTAssertTrue(feedController.didCallDeleteFeed)
    }
}

// Since our ViewModels are pretty simple, and there is not much going on, tests are not complicated.
// Basically ViewModels are unnecessary when we have a FeedController.
// ViewModels are here just for a code separation.

class FeedControllerMock: FeedControllerProtocol {
    var feedProviders: CurrentValueSubject<[RSSFeedReponse], Never> = .init([])
    var errorMessage: CurrentValueSubject<ParserError?, Never> = .init(nil)
    var showAlert: CurrentValueSubject<Bool, Never> = .init(false)
    var feedService = FeedParserService()
    
    var didCallStartFeedKit: Bool = false
    var didCallFavouriteSelected: Bool = false
    var didCallAddOrUpdate: Bool = false
    var didCallDeleteAtOffset: Bool = false
    var didCallDeleteFeed: Bool = false

    func startFeedKit(with url: String) {
        didCallStartFeedKit = true
    }
    
    func favouriteSelected(_ feed: RSSFeedReponse) {
        didCallFavouriteSelected = true
    }
    
    func addOrUpdateFeed(_ feed: RSSFeedReponse) {
        didCallAddOrUpdate = true
    }
    
    func delete(at offsets: IndexSet) {
        didCallDeleteAtOffset = true
    }
    
    func delete(_ feed: RSSFeedReponse) {
        didCallDeleteFeed = true
    }
}
