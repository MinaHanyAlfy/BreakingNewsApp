//
//  News.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation

// MARK: - News
struct News: Decodable {
    let status, code, message: String?
    let totalResults: Int?
    let articles: [Article]?
}


