//
//  Comment+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 13.07.2022.
//
//

import Foundation
import CoreData

extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var text: String?
    @NSManaged public var person: Person?

}

extension Comment: Identifiable {

}
