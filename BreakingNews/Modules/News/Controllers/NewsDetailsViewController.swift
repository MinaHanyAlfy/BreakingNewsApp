//
//  NewsDetailsViewController.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showArticalButton.layer.cornerRadius = 18        
    }

    @IBAction func showArticalAction(_ sender: Any) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
    }
  
}
