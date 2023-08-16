//
//  Source.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-12.
//

import Foundation

// MARK: - Source
struct Source: Decodable, Identifiable {
    var id: String?
    var name: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
