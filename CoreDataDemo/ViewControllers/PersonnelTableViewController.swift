//
//  PersonnelTableViewController.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 10.07.2022.
//

import UIKit
import CoreData

class PersonnelTableViewController: UITableViewController {

    struct Constants {
        static let entity = "Person"
        static let sortName = "name"
        static let cellName = "CellPerson"
        static let segueId = "AddPersonSegue"
    }
    
    var fetchedResultsController = CoreDataManager.shared.fetchedResultsController(
        entityName: Constants.entity,
        sortKey: Constants.sortName) as! NSFetchedResultsController<Person>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)
        let person = fetchedResultsController.object(at: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = person.name
        config.secondaryText = person.department
        cell.contentConfiguration = config
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let person = fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: Constants.segueId, sender: person)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddPersonViewController,
           let person = sender as? Person,
            segue.identifier == Constants.segueId {
            vc.person = person
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = fetchedResultsController.object(at: indexPath)
            CoreDataManager.shared.context.delete(person)
            CoreDataManager.shared.saveContext()
        }
    }
}

extension PersonnelTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let person = fetchedResultsController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath)
                var config = cell?.defaultContentConfiguration()
                config?.text = person.name
                config?.secondaryText = person.department
                cell?.contentConfiguration = config
            }
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
