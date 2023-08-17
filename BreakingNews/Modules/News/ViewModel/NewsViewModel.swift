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
    
    func process(intent: NewsIntent)
    
    func articleTitle() -> String
    func articleSourceName() -> String
    func articleDate() -> String
    func articleContent() -> String
    func articleDescription() -> String
    func articleImage() -> String
    func articleAuthor() -> String
    func articleUrl() -> String
}

class NewsViewModel: NewsViewModelProtocol, ObservableObject {
    var selectedArticle: Article?
    
    @Published private(set) var viewState: ArticlesViewState = ArticlesViewState(articles: [], errorMessage: .none)
        
    
    @Published private var error: ErrorMessage? = nil
    var errorPublisher: Published<ErrorMessage?>.Publisher {$error}
    
    @Published private var newsDataSuccess: Bool? = nil
    var newsSuccessPublisher: Published<Bool?>.Publisher {$newsDataSuccess}
    
    @Published var articles: [Article] = []
    var query: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    private var repo: NewsRepositoryProtocol?
    private var cancellabels = Set<AnyCancellable>()
    
    init(repo: NewsRepository = NewsRepository()) {
        self.repo = repo
    }
    
    func process(intent: NewsIntent) {
        switch intent {
        case .loadNews:
            getNews()
        case .loadSpecificNews(let query):
            getSpecificNews(query: query)
        case .selectedNews(let index):
            self.selectedArticle = articles[index]
        case .fetchNewsSwiftUI:
            getNews()
        }
    }
    
    func getNews() {
        repo?.getNews()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                    self?.viewState.errorMessage = error
                }
            }, receiveValue: { [weak self] data in
                self?.articles = data
                self?.newsDataSuccess = true
                self?.viewState.articles = data
            })
            .store(in: &cancellabels)
    }
    
    
    func getSpecificNews(query: String) {
        self.query = query
        repo?.getSpecificNews(query: query)
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
    
    deinit {
        print("NewsViewModel instance deinit")
    }
}

