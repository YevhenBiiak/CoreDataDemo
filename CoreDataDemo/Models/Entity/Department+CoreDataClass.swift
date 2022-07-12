//
//  Department+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 11.07.2022.
//
//

import Foundation
import CoreData

@objc(Department)
public class Department: NSManagedObject {
    
    convenience init(name: String) {
        self.init(entity: CoreDataManager.shared.entityDescription(forName: "Department")!, insertInto: CoreDataManager.shared.context)
        self.name = name
    }
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityDescription(forName: "Department")!, insertInto: CoreDataManager.shared.context)
    }

}
