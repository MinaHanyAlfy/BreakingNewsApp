//
//  NewsRepository.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation
import Combine
import CoreData


protocol NewsRepositoryProtocol {
    func getNews() -> AnyPublisher<[Article], ErrorMessage>
    func getSpecificNews(query: String) -> AnyPublisher<[Article], ErrorMessage>
}

class NewsRepository: NewsRepositoryProtocol {
    private var cancellabels = Set<AnyCancellable>()
    private let coredate = CoreDataManager.shared
    private let connectionChecker = ConnectionChecker.shared
    
    func getNews() -> AnyPublisher<[Article], ErrorMessage> {
        
        let subject = PassthroughSubject<[Article], ErrorMessage>()
        let configurationRequest = API.getNews
        let publisher = subject.eraseToAnyPublisher()
        
        if connectionChecker.isInternetAvailable() {
            RequestManager.beginRequest(request: configurationRequest, model: News.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { news in
                    subject.send(news.articles ?? [])
                    if news.articles?.count ?? 0 > 0  {
                        self.coredate.clearArticles()
                        self.coredate.saveArticles(articles: news.articles ?? [])
                    }
    //                subject.send(self.coredate.getArticles())
    //                self.coredate.saveArticles(articles: news.articles ?? [])
                })
                .store(in: &cancellabels)
            print("Connected")
            return publisher
        } else {
            print("NOT Connected")
            
//            subject.send(coredate.getArticles())
            return Just(coredate.getArticles())
                .setFailureType(to: ErrorMessage.self)
                .eraseToAnyPublisher()
        }
    }
    
    func getSpecificNews(query: String) -> AnyPublisher<[Article], ErrorMessage> {
        
        let subject = PassthroughSubject<[Article], ErrorMessage>()
        let configurationRequest = API.getSpecificNews(query: query)
        let publisher = subject.eraseToAnyPublisher()
        
        RequestManager.beginRequest(request: configurationRequest, model: News.self)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    subject.send(completion: .failure(error))
                }
            },receiveValue: { news in
                subject.send(news.articles ?? [])
            })
            .store(in: &cancellabels)
        return publisher
    }
}

