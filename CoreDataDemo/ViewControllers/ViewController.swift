//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 10.07.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataManager = CoreDataManager.shared
        
        // create managed object
        let person1 = Person(name: "Jhon", age: 22, department: "")
        let person2 = Person(name: "Anna", age: 29, department: "")
        let person3 = Person(name: "David", age: 33, department: "")
        
        print("\(person1.name!) \(person1.age)")
        print("\(person2.name!) \(person1.age)")
        print("\(person3.name!) \(person1.age)")
        
        // save data from context
        dataManager.saveContext()
        
        // fetsh data into context
        do {
            let results = try dataManager.context.fetch(Person.fetchRequest())
            for result in results {
                print("name - \(result.name!), age - \(result.age)")
            }
        } catch {
            print(error)
        }
        
        // remove all objects from context
        do {
            let results = try dataManager.context.fetch(Person.fetchRequest())
            for result in results {
                dataManager.context.delete(result)
            }
        } catch {
            print(error)
        }

        // save empty data from context
        dataManager.saveContext()
        
    }
}
