//
//  NewsDetailsViewController.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import UIKit
import SafariServices

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceStackView: UIStackView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorStackView: UIStackView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var showArticalButton: UIButton!
    
    var viewModel: NewsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func showArticalAction(_ sender: Any) {
        guard let url = URL(string: viewModel?.articleUrl() ?? "") else { return }
        let sfVc = SFSafariViewController(url: url)
        navigationController?.present(sfVc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = self.viewModel else {
            return
        }
        newsImageView.loadImageUsingCacheWithURLString(viewModel.articleImage(), placeHolder: UIImage(named: "news"))
        authorLabel.text = viewModel.articleAuthor()
        sourceLabel.text = viewModel.articleSourceName()
        contentLabel.text = viewModel.articleContent()
        descriptionLabel.text = viewModel.articleDescription()
        newsDateLabel.text = viewModel.articleDate()
        titleLabel.text = viewModel.articleTitle()
        showArticalButton.layer.cornerRadius = 18
    }
    
}
