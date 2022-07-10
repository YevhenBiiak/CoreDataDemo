//
//  Person+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 10.07.2022.
//
//

import Foundation
import CoreData

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}

extension Person: Identifiable {

}
