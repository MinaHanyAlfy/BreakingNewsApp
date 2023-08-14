//
//  NewsRepository.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {
    func getNews(pageNumber: Int) -> AnyPublisher<[Article], ErrorMessage>
    func getSpecificNews(query: String, pageNumber: Int) -> AnyPublisher<[Article], ErrorMessage>
    
    var articles: [Article] {get set}
    var loadMore: Bool {set get}
    var firstCall: Bool {set get}
}

class NewsRepository: NewsRepositoryProtocol {
    private var cancellabels = Set<AnyCancellable>()
    var loadMore: Bool = true
    var firstCall: Bool = true
    var articles: [Article] = []
    
    func getNews(pageNumber: Int) -> AnyPublisher<[Article], ErrorMessage> {
        
        let subject = PassthroughSubject<[Article], ErrorMessage>()
        let configurationRequest = API.getNews(pageNumber: pageNumber)
        let publisher = subject.eraseToAnyPublisher()
        if loadMore {
            RequestManager.beginRequest(request: configurationRequest, model: News.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { news in
                    if self.firstCall {
                        self.articles = news.articles ?? []
                        self.firstCall = false
                    } else {
                        self.articles.append(contentsOf: news.articles ?? [])
                    }
                    subject.send(self.articles)
                    if self.articles.count == news.totalResults {
                        self.loadMore = false
                    } else {
                        self.loadMore = true
                    }
                })
                .store(in: &cancellabels)
            return publisher
        } else {
            subject.send(articles)
            return publisher
        }
        
    }
    
    func getSpecificNews(query: String, pageNumber: Int) -> AnyPublisher<[Article], ErrorMessage> {

        let subject = PassthroughSubject<[Article], ErrorMessage>()
        let configurationRequest = API.getSpecificNews(query: query, pageNumber: pageNumber)
        let publisher = subject.eraseToAnyPublisher()
        if loadMore {
            RequestManager.beginRequest(request: configurationRequest, model: News.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { news in
                    if self.firstCall {
                        self.articles = news.articles ?? []
                        self.firstCall = false
                    } else {
                        self.articles.append(contentsOf: news.articles ?? [])
                    }
                    subject.send(self.articles)
                    if self.articles.count == news.totalResults {
                        self.loadMore = false
                    } else {
                        self.loadMore = true
                    }
                })
                .store(in: &cancellabels)
            return publisher }
        else {
            subject.send(articles)
            return publisher
        }
        
    }
    
}
