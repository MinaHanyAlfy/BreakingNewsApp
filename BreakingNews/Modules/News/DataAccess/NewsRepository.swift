//
//  NewsRepository.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {
    func getNews() -> AnyPublisher<[Article], ErrorMessage>
    func getSpecificNews(query: String) -> AnyPublisher<[Article], ErrorMessage>
}

class NewsRepository: NewsRepositoryProtocol {
    private var cancellabels = Set<AnyCancellable>()
    
    func getNews() -> AnyPublisher<[Article], ErrorMessage> {
        
        let subject = PassthroughSubject<[Article], ErrorMessage>()
        let configurationRequest = API.getNews
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

