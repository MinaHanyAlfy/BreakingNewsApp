//
//  NewsViewController.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    var newsDetailsViewController: NewsDetailsViewController?
    private var cancellabels = Set<AnyCancellable>()
    
    private var viewModel: NewsViewModelProtocol!
    private let tableView :UITableView = {
        let tableView = UITableView()
        tableView.registerCell(tableViewCell: NewsTableViewCell.self)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
//        tableView.dele
        return tableView
    }()
    
    private let searchController : UISearchController = {
        let searchResultViewController = SearchResultViewController()
        let controller = UISearchController(searchResultsController: searchResultViewController)
        controller.searchBar.placeholder = "Search for BREAKING NEWS..."
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NewsViewModel()
        viewModel.process(intent: .loadNews(pageNumber: 1))
        bindData()
        setupTableView()
        setupNavigation()
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
    
    private func setupNavigation() {
        navigationItem.title = "BREAKING NEWS"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        navigationController?.present(alert, animated: true)
    }
    
    private func fetchSuccess() {
        tableView.reloadData()
    }
    
}
//MARK: - UITableViewDataSource -
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(tableViewCell: NewsTableViewCell.self , forIndexPath: indexPath)
        let index = indexPath.row
        cell.config(article: viewModel.articals[index])
        return cell
        
    }
}
//MARK: - UITableViewDelegate -
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        newsDetailsViewController = NewsDetailsViewController()
        navigationController?.pushViewController(newsDetailsViewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.position(index: index)
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
