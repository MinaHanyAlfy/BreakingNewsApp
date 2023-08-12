//
//  Artical.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation

// MARK: - Article
struct Article: Decodable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
}
