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
    
    var selectedArticle: Article? {set get}
    var articles: [Article] {set get}
    var pageNumber: Int {set get}
    
    func process(intent: NewsIntent)
    func position(index: Int)
    
    func articleTitle() -> String
    func articleSourceName() -> String
    func articleDate() -> String
    func articleContent() -> String
    func articleDescription() -> String
    func articleImage() -> String
    func articleAuthor() -> String
    func articleUrl() -> String
}

class NewsViewModel: NewsViewModelProtocol {
    var selectedArticle: Article?
    
    @Published private var error: ErrorMessage? = nil
    var errorPublisher: Published<ErrorMessage?>.Publisher {$error}
    
    @Published private var newsDataSuccess: Bool? = nil
    var newsSuccessPublisher: Published<Bool?>.Publisher {$newsDataSuccess}
    
    @Published var articles: [Article] = []
    
    
    
    
    var query: String = ""
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
        case .loadSpecificNews(let query, let pageNumber):
            repo.articles = []
            repo.loadMore = true
            repo.firstCall = true
            
            getSpecificNews(query: query,pageNumber: pageNumber)
            
        case .selectedNews(let index):
            self.selectedArticle = articles[index]
            return
        }
    }
    
    func getNews(pageNumber: Int? = 1) {
        self.pageNumber = pageNumber ?? 1
        repo.getNews(pageNumber: self.pageNumber)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] data in
                self?.articles = data
                self?.newsDataSuccess = true
            })
            .store(in: &cancellabels)
    }
    
    func getSpecificNews(query: String, pageNumber: Int? = 1) {
        
        self.pageNumber = pageNumber ?? 1
        self.query = query
        repo.getSpecificNews(query: query, pageNumber: self.pageNumber)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] data in
                self?.articles = data
                self?.newsDataSuccess = true
                
            })
            .store(in: &cancellabels)
    }
    
    func position(index: Int) {
        if index == articles.count - 1 {
            count = articles.count - 1
            diff = abs(count - index)
            if diff == 0 {
                pageNumber += 1
                if query != "" {
                    process(intent: .loadSpecificNews(query: query,pageNumber: pageNumber))
                }
                process(intent: .loadNews(pageNumber: pageNumber))
            }
        }
    }
    
    func articleTitle() -> String {
        if selectedArticle != nil {
            return selectedArticle?.title ?? ""
        }
        return ""
    }
    func articleSourceName() -> String {
        if selectedArticle != nil {
            return selectedArticle?.source?.name ?? ""
        }
        return ""
    }
    func articleDate() -> String {
        if selectedArticle != nil {
            return selectedArticle?.publishedAt ?? ""
        }
        return ""
    }
    func articleContent() -> String {
        if selectedArticle != nil {
            return selectedArticle?.content ?? ""
        }
        return ""
    }
    func articleDescription() -> String {
        if selectedArticle != nil {
            return selectedArticle?.description ?? ""
        }
        return ""
    }
    
    func articleImage() -> String {
        if selectedArticle != nil {
            return selectedArticle?.urlToImage ?? ""
        }
        return ""
    }
    
    func articleAuthor() -> String {
        if selectedArticle != nil {
            return selectedArticle?.author ?? ""
        }
        return ""
    }
    
    func articleUrl() -> String {
        if selectedArticle != nil {
            return selectedArticle?.url ?? ""
        }
        return ""
    }

    
}
