//
//  API.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-11.
//

import Foundation

enum API {
    case getNews(pageNumber: Int)
    case getSpecificNews(query: String, pageNumber: Int)
}

extension API: EndPoint {
    
    var baseURL: String {
        return "https://newsapi.org"
    }
    
    var urlSubFolder: String {
        return "/v2"
    }
    
    var path: String {
        return "everything"
    }
    
    
    var queryItems: [URLQueryItem] {
        let langDeviceCode = Locale.current.languageCode
        
        switch self {
        case .getNews(let pageNumber):
            return [
                URLQueryItem(name: "q", value: "everything"),
                URLQueryItem(name: "page", value: "\(pageNumber)"),
                URLQueryItem(name: "pageSize", value: "50"),
                URLQueryItem(name: "sortBy", value: "publishedAt"),
                URLQueryItem(name: "language", value: langDeviceCode),
                URLQueryItem(name: "apiKey", value: "8e5161eb2e744e4ab03c255267d94f75")
            ]
            
        case .getSpecificNews(let query, let pageNumber):
            return [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "sortBy", value: "publishedAt"),
                URLQueryItem(name: "page", value: "\(pageNumber)"),
                URLQueryItem(name: "pageSize", value: "50"),
                URLQueryItem(name: "sortBy", value: "publishedAt"),
                URLQueryItem(name: "language", value: langDeviceCode),
                URLQueryItem(name: "apiKey", value: "8e5161eb2e744e4ab03c255267d94f75")
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default :
            return  .get
        }
    }

    var body: [String: Any]? {
        switch self{
        default:
            return nil
        }
    }
}
