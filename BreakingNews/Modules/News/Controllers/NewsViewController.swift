//
//  NewsViewController.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import UIKit

class NewsViewController: UIViewController {
    var newsDetailsViewController: NewsDetailsViewController?
    
    private let tableView :UITableView = {
        let tableView = UITableView()
        tableView.registerCell(tableViewCell: NewsTableViewCell.self)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        
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
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
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

}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(tableViewCell: NewsTableViewCell.self , forIndexPath: indexPath)
        _ = indexPath.row
        
        return cell
        
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        newsDetailsViewController = NewsDetailsViewController()
        navigationController?.pushViewController(newsDetailsViewController!, animated: true)
    }
}
