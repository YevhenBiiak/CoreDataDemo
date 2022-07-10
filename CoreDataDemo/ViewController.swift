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
        
        // create manager of objects
        let managerObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        // set atribute values
        managerObject.setValue("Jhon", forKey: "name")
        managerObject.setValue(18, forKey: "age")
        
        // get atribute values
        let name = managerObject.value(forKey: "name")
        let age = managerObject.value(forKey: "age")
        
        print("\(name) \(age)")
        
        // save data
        appDelegate.saveContext()
        
        // get data
        let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            for result in results! {
                print("name - \(result.value(forKey: "name")), age - \(result.value(forKey: "age"))")
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
