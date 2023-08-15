//
//  API.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-11.
//

import Foundation

enum API {
    case getNews
    case getSpecificNews(query: String)
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
        case .getNews:
            return [
                URLQueryItem(name: "q", value: "everything"),
                URLQueryItem(name: "sortBy", value: "publishedAt"),
                URLQueryItem(name: "language", value: langDeviceCode),
                URLQueryItem(name: "apiKey", value: "95cf1749f95b4b938f5bb3aaf284ef4a")
            ]
            
        case .getSpecificNews(let query):
            return [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "sortBy", value: "publishedAt"),
                URLQueryItem(name: "language", value: langDeviceCode),
                URLQueryItem(name: "apiKey", value: "95cf1749f95b4b938f5bb3aaf284ef4a")
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
