//
//  ArticleCell.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-16.
//

import SwiftUI

struct ArticleCell: View {
    var article: Article
    
    var body: some View {
        HStack {
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: article.urlToImage ?? "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100, maxHeight: 80)
                    case .failure:
                        Image(systemName: "news")
                    @unknown default:
                        
                        EmptyView()
                    }
                }
            } else {
                Image("news")
                // Fallback on earlier versions
            }
            VStack {
                Text(article.title ?? "Title")
                    .font(.headline)
                Text(article.source?.name ?? "Source")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        
    }
}

struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article(id: nil, source: nil, author: nil, title: nil, description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
        ArticleCell(article: article)
    }
}

