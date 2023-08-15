//
//  SourceCD+CoreDataProperties.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-15.
//
//

import Foundation
import CoreData


extension SourceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceCD> {
        return NSFetchRequest<SourceCD>(entityName: "SourceCD")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension SourceCD : Identifiable {

}
