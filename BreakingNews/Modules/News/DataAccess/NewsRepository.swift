//
//  NewsRepository.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation
import Combine

protocol RepoRepositoryProtocol {
    func getNews(pageNumber: Int) -> AnyPublisher<News, ErrorMessage>
    func getSpecificNews(query: String, pageNumber: Int) -> AnyPublisher<News, ErrorMessage>
}

class RepoRepository: RepoRepositoryProtocol {
    private var cancellabels = Set<AnyCancellable>()
    
    func getNews(pageNumber: Int) -> AnyPublisher<News, ErrorMessage> {
        let subject = PassthroughSubject<News, ErrorMessage>()
        let configurationRequest = API.getNews(pageNumber: pageNumber)
        let publisher = subject.eraseToAnyPublisher()

            RequestManager.beginRequest(request: configurationRequest, model: News.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                })
                .store(in: &cancellabels)
            return publisher
    }
    
    func getSpecificNews(query: String, pageNumber: Int) -> AnyPublisher<News, ErrorMessage> {
        let subject = PassthroughSubject<News, ErrorMessage>()
        let configurationRequest = API.getSpecificNews(query: query, pageNumber: pageNumber)
        let publisher = subject.eraseToAnyPublisher()

            RequestManager.beginRequest(request: configurationRequest, model: News.self)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        subject.send(completion: .failure(error))
                    }
                },receiveValue: { repos in
                    subject.send(repos)
                })
                .store(in: &cancellabels)
            return publisher
    }

}
