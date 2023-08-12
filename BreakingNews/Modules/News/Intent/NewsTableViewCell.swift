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
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.label.cgColor
//        mainView.layer.shadowOffset =
        mainView.layer.shadowOffset = CGSize(width: 2, height: 2)
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowColor = UIColor.gray.cgColor
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
