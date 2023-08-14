//
//  NewsIntent.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation

enum NewsIntent {
    case loadNews(pageNumber: Int)
    case loadSpecificNews(query: String, pageNumber: Int? = 1)
    case selectedNews(index: Int)
}


