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
        let managedObject = Person()
        
        // set atribute values
        managedObject.name = "Anna"
        managedObject.age = 24
        
        // get atribute values
        let name = managedObject.name
        let age = managedObject.age
        
        print("\(name!) \(age)")
        
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
