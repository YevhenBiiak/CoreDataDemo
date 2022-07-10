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
        
        // get reference to AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // create context
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // enity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        // create managed object
        let managedObject = Person(entity: entityDescription!, insertInto: context)
        
        // set atribute values
        managedObject.name = "Anna"
        managedObject.age = 24
        
        // get atribute values
        let name = managedObject.name
        let age = managedObject.age
        
        print("\(name) \(age)")
        
        // save data
        appDelegate.saveContext()
        
        // get data
        let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try context.fetch(fetchRequest) as? [Person]
            for result in results! {
                print("name - \(result.name), age - \(result.age)")
            }
        } catch {
            print(error)
        }
        
        // remove all objects from context
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            for result in results! {
                context.delete(result)
            }
        } catch {
            print(error)
        }
        appDelegate.saveContext()
        
    }
}
