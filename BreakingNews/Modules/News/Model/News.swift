//
//  News.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation

// MARK: - News
struct News: Decodable {
    var status: String? = ""
    var code: String? = ""
    var message: String? = ""
    var totalResults: Int? = 0
    var articles: [Article]? = []
    
    enum CodingKeys: String, CodingKey {
        case status, code, message
        case totalResults, articles
        
    }
    
}
