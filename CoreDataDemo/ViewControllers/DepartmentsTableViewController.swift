//
//  DepartmentsTableViewController.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 11.07.2022.
//

import UIKit
import CoreData

class DepartmentsTableViewController: UITableViewController {
    
    struct Constants {
        static let entity = "Department"
        static let sortName = "name"
        static let cellName = "CellDepartment"
        static let segueId = "AddDepartmentSegue"
    }
    
    var fetchedResultsController: NSFetchedResultsController<Department> = CoreDataManager.shared.fetchedResultsController(
        entityName: Constants.entity,
        sortKey: Constants.sortName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.delegate = self
        
        do { try fetchedResultsController.performFetch()
        } catch { print(error) }
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
        let department = fetchedResultsController.object(at: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = department.name
        cell.contentConfiguration = config
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let department = fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: Constants.segueId, sender: department)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddDepartmentViewController,
           let department = sender as? Department,
            segue.identifier == Constants.segueId {
            vc.department = department
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let department = fetchedResultsController.object(at: indexPath)
            CoreDataManager.shared.context.delete(department)
            CoreDataManager.shared.saveContext()
        }
    }
}

extension DepartmentsTableViewController: NSFetchedResultsControllerDelegate {
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
                let department = fetchedResultsController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath)
                var config = cell?.defaultContentConfiguration()
                config?.text = department.name
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
