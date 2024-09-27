//
//  RSSFeedViewModel.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import FeedKit
import Combine

class RSSFeedViewModel: ObservableObject {
    @Published var feedProviders: [RSSFeedReponse]
    @Published var rssFeedUrl: String = ""
    @Published var isSheetPresented: Bool = false
    @Published var errorMessage: ParserError?
    @Published var showAlert: Bool
    
    var feedController: FeedController
    private var cancellables = Set<AnyCancellable>()

    init(feedController: FeedController) {
        self.feedController = feedController
        
        feedProviders = feedController.feedProviders.value
        errorMessage = feedController.errorMessage.value
        showAlert = feedController.showAlert.value
        
        setSink()
    }
}

// MARK: - Observers
private extension RSSFeedViewModel {
     func setSink() {
        feedController.feedProviders.sink { [weak self] in
            self?.feedProviders = $0
        }.store(in: &cancellables)
        
        feedController.showAlert.sink { [weak self] shouldShowAlert in
            self?.showAlert = shouldShowAlert
        }.store(in: &cancellables)
        
        feedController.errorMessage.sink { [weak self] errorMessage in
            self?.errorMessage = errorMessage
        }.store(in: &cancellables)
    }
}

// MARK: - Data parser
extension RSSFeedViewModel {
    func startFeedKit(with url: String) {
        feedController.startFeedKit(with: url)
    }
}

// MARK: - Update current data
extension RSSFeedViewModel {
    func favouriteSelected(_ feed: RSSFeedReponse) {
        feedController.addOrUpdateFeed(feed)
    }
    
    func delete(at offsets: IndexSet) {
        feedController.delete(at: offsets)
    }
    
    func addOrUpdateFeed(_ feed: RSSFeedReponse) {
        feedController.addOrUpdateFeed(feed)
    }
}
