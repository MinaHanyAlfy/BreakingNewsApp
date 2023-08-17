//
//  NewsViewsModelTests.swift
//  BreakingNewsTests
//
//  Created by Mina Hanna on 2023-08-17.
//

import XCTest
import Combine
@testable import BreakingNews

final class NewsViewsModelTests: XCTestCase {
    
    var viewModel: NewsViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = NewsViewModel(repo: MockNewsRepository())
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Helper Methods
    
    func waitForExpectations() {
        waitForExpectations(timeout: 1.0)
    }
    
    
    
    func testGetNews_Success() {
        let expectation = expectation(description: "Get news success")
        
        viewModel.newsSuccessPublisher
            .dropFirst()
            .sink { success in
                XCTAssertEqual(success, true, "Expected news data success to be true")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getNews()
        
        waitForExpectations()
    }
    
    func testGetSpecificNews_Success() {
        let expectation = expectation(description: "Get specific news success")
        
        viewModel.newsSuccessPublisher
            .dropFirst()
            .sink { success in
                XCTAssertEqual(success, true, "Expected specific news data success to be true")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getSpecificNews(query: "example")
        
        waitForExpectations()
    }
    
    func testArticleTitle() {
        viewModel.selectedArticle = Article(id: nil, source: nil, author: "John Doe", title: "Example Title", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
        
        let title = viewModel.articleTitle()
        
        XCTAssertEqual(title, "Example Title", "Expected article title to be 'Example Title'")
    }
    
}

class MockNewsRepository: NewsRepository {
    override func getNews() -> AnyPublisher<[Article], ErrorMessage> {
        // Simulate a successful response
        let articles = [
            Article(id: nil, source: nil, author: "John Doe", title: "Example Title", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
        ]
        return Just(articles)
            .setFailureType(to: ErrorMessage.self)
            .eraseToAnyPublisher()
    }
    
    override func getSpecificNews(query: String) -> AnyPublisher<[Article], ErrorMessage> {
        // Simulate a successful response for specific news
        let articles = [
            Article(id: nil, source: nil, author: "Jane Smith", title: "Specific Example", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
        ]
        return Just(articles)
            .setFailureType(to: ErrorMessage.self)
            .eraseToAnyPublisher()
    }
}
