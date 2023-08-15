//
//  CoreDataManager.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-15.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private var context: NSManagedObjectContext?
    
    func mgContext() ->  NSManagedObjectContext {
        let context = appDelegate().persistentContainer.viewContext
        return context
    }
    
    init() {
        self.context = mgContext()
    }
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func save() {
        appDelegate().saveContext()
    }
    
}
//MARK: - Save, Clear And GET Articles -
extension CoreDataManager {
    func saveArticles(articles: [Article]) {
        for article in articles {
            let articleCD = ArticleCD(context: context!)
            let sourceCD = SourceCD(context: context!)
            articleCD.title = article.title
            articleCD.desc = article.description
            articleCD.content = article.content
            articleCD.url = article.url
            articleCD.urlToImage = article.urlToImage
            articleCD.author = article.author
            articleCD.publishedAt = article.publishedAt
            sourceCD.id = article.source?.id
            sourceCD.name = article.source?.name
            articleCD.source = sourceCD

            do {
                try context?.save()
                print("✅ Success")
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func clearArticles() {
        let fetchRequest = ArticleCD.fetchRequest()
        let objects = try! context!.fetch(fetchRequest)
        for obj in objects {
            context!.delete(obj)
        }
        
        do {
            try context!.save()
        } catch {
            print("❌ Error Delete Object")
        }
    }
    
    func getArticles() -> [Article] {
        let fetchRequest = ArticleCD.fetchRequest()
        let objects = try! context!.fetch(fetchRequest)
        var articles: [Article] = []
        for objc in objects {
            let article = Article(source: Source(id: objc.source?.id, name: objc.source?.name), author: objc.author, title: objc.title, description: objc.desc, url: objc.url, urlToImage: objc.urlToImage, publishedAt: objc.publishedAt, content: objc.content)

            articles.append(article)
        }
        return articles
    }
}
