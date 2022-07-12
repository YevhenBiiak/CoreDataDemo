//
//  Department+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 11.07.2022.
//
//

import Foundation
import CoreData

extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var name: String?

}

extension Department: Identifiable {

}
