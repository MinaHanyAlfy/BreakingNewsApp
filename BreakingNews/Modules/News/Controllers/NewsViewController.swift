//
//  NewsViewController.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    lazy var newsDetailsViewController: NewsDetailsViewController = NewsDetailsViewController()
    
    private var cancellabels = Set<AnyCancellable>()
    let langDeviceCode = Locale.current.languageCode ?? "en"

    private var viewModel: NewsViewModelProtocol!
    private let tableView :UITableView = {
        let tableView = UITableView()
        tableView.registerCell(tableViewCell: NewsTableViewCell.self)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsViewModel()
        viewModel.process(intent: .loadNews)
        bindData()
        configureNavBar()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationItem.titleView?.backgroundColor = .systemBackground
        navigationItem.titleView?.tintColor = .label
        navigationController?.navigationBar.backgroundColor = .systemBackground
        searchBar = UISearchBar()
        searchBar?.delegate = self
        searchBar?.tintColor = .label
        navigationItem.titleView = searchBar
        searchBar?.placeholder = "Search for BREAKING NEWS...".localizeString(string: langDeviceCode)
        searchBar?.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert".localizeString(string: langDeviceCode), message: message.localizeString(string: langDeviceCode), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localizeString(string: langDeviceCode), style: .cancel))
        navigationController?.present(alert, animated: true)
    }
    
    private func fetchSuccess() {
        tableView.reloadData()
    }
    
}
//MARK: - UITableViewDataSource -
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(tableViewCell: NewsTableViewCell.self , forIndexPath: indexPath)
        let index = indexPath.row
        
        cell.config(article: viewModel.articles[index])
        return cell
        
    }
}
//MARK: - UITableViewDelegate -
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.process(intent: .selectedNews(index: index))
        newsDetailsViewController.viewModel = viewModel
        navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
}

//MARK: - For Binding Data -
extension NewsViewController {
    func bindData() {
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                if let error = error {
                    self?.showAlert(message: error.rawValue)
                }
            })
            .store(in: &cancellabels)
        
        viewModel.newsSuccessPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] fetched in
                if fetched ?? false {
                    self?.fetchSuccess()
                }
            })
            .store(in: &cancellabels)
    }
}

//MARK: - UISearchBarDelegate -
extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.lowercased()
        if !query.trimmingCharacters(in: .whitespaces).isEmpty,
           query.trimmingCharacters(in: .whitespaces).count >= 3 {
            viewModel.process(intent: .loadSpecificNews(query: query))
        }
        
        if query.isEmpty {
            viewModel.process(intent: .loadNews)
        }
    }    
}

