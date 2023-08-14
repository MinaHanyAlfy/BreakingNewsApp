//
//  NewsViewModel.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation
import Combine

protocol NewsViewModelProtocol {
    var errorPublisher: Published<ErrorMessage?>.Publisher {get}
    var newsSuccessPublisher: Published<Bool?>.Publisher {get}
    
    var articals: [Article] {set get}
    var pageNumber: Int {set get}
    
    func process(intent: NewsIntent)
    func position(index: Int)
}

class NewsViewModel: NewsViewModelProtocol {
    
    @Published private var error: ErrorMessage? = nil
    var errorPublisher: Published<ErrorMessage?>.Publisher {$error}
    
    @Published private var newsDataSuccess: Bool? = nil
    var newsSuccessPublisher: Published<Bool?>.Publisher {$newsDataSuccess}
    
    @Published var articals: [Article] = []
    
    var pageNumber: Int = 1
    var count = 0
    var diff = 0
    private var cancellables = Set<AnyCancellable>()
    
    private var repo: NewsRepositoryProtocol!
    private var cancellabels = Set<AnyCancellable>()
    
    init(repo: NewsRepository = NewsRepository()) {
        self.repo = repo
    }
    
    func process(intent: NewsIntent) {
        switch intent {
        case .loadNews(let pageNumber):
            getNews(pageNumber: pageNumber)
        case .loadSpecificNews:
            //            getSpecificNews(query:)
            return
        case .selectedNews(let index):
            let selectedNews = articals[index]
            print(selectedNews)
            return
        }
    }
    
    func getNews(pageNumber: Int? = 1) {
        repo.getNews(pageNumber: pageNumber ?? 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] data in
                self?.articals = data
                self?.newsDataSuccess = true
            })
            .store(in: &cancellabels)
    }
    
    func getSpecificNews(query: String, pageNumber: Int? = 0) {
        repo.getSpecificNews(query: query, pageNumber: pageNumber ?? 0)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] data in
                
            })
            .store(in: &cancellabels)
    }
    
    func position(index: Int) {
        if index == articals.count - 1 {
            count = articals.count - 1
            diff = abs(count - index)
            if diff == 0 {
                pageNumber += 1
                process(intent: .loadNews(pageNumber: pageNumber))
            }
        }
    }
}
