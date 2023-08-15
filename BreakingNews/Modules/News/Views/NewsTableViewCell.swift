//
//  NewsTableViewCell.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
  
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 8
        newsImageView.layer.cornerRadius = 8
        newsImageView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(article: Article) {
        newsImageView.loadImageUsingCacheWithURLString(article.urlToImage ?? "", placeHolder: UIImage(named: "news"))

        newsTitleLabel.text = article.title ?? "NO TITLE"
        newsSourceLabel.text = article.source?.name ?? "NO SOURCE"
    }
    
    func config(articleImage: String, articleTitle: String, articleSourceName: String) {
        newsImageView.loadImageUsingCacheWithURLString(articleImage, placeHolder: UIImage(named: "news"))

        newsTitleLabel.text = articleTitle
        newsSourceLabel.text = articleSourceName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = UIImage(named: "news")
        newsTitleLabel.text = ""
        newsSourceLabel.text = ""
        
    }
}
