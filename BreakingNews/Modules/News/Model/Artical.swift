//
//  Artical.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation

// MARK: - Article
struct Article: Decodable, Identifiable{
    var id: ObjectIdentifier?
    
    var source: Source?
    var author: String? = ""
    var title: String? = ""
    var description: String? = ""
    var url: String? = ""
    var urlToImage: String? = ""
    var publishedAt: String? = ""
    var content: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case source, title, description
        case author, url
        case urlToImage, publishedAt, content
    }
}
