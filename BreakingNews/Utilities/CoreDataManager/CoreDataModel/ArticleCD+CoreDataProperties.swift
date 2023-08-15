//
//  ArticleCD+CoreDataProperties.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-15.
//
//

import Foundation
import CoreData


extension ArticleCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleCD> {
        return NSFetchRequest<ArticleCD>(entityName: "ArticleCD")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?
    @NSManaged public var source: SourceCD?
}

extension ArticleCD : Identifiable {
    
}
