//
//  NewsIntent.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation

enum NewsIntent {
    case loadNews
    case loadSpecificNews
    case selectedNews(index: Int)
}


