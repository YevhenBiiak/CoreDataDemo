//
//  Comment+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 13.07.2022.
//
//

import Foundation
import CoreData

@objc(Comment)
public class Comment: NSManagedObject {
    
    convenience init(text: String?) {
        self.init(entity: CoreDataManager.shared.entityDescription(forName: "Comment")!, insertInto: CoreDataManager.shared.context)
        self.text = text
    }
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityDescription(forName: "Comment")!, insertInto: CoreDataManager.shared.context)
    }
    
}
