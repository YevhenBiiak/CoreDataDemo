//
//  Person+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 10.07.2022.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    
    convenience init(name: String, age: Int16) {
        self.init(entity: CoreDataManager.shared.entityDescription(forName: "Person")!, insertInto: CoreDataManager.shared.context)
        self.name = name
        self.age = age
    }
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityDescription(forName: "Person")!, insertInto: CoreDataManager.shared.context)
    }
    
}
