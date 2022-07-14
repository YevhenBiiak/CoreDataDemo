//
//  AddPersonViewController.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 10.07.2022.
//

import UIKit
import CoreData

class AddPersonViewController: UIViewController {
    
    struct Constants {
        static let entity = "Department"
        static let sortName = "name"
    }
    
    var fetchedResultsController: NSFetchedResultsController<Department> = CoreDataManager.shared.fetchedResultsController(
        entityName: Constants.entity,
        sortKey: Constants.sortName)

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextFiled: UITextField!
    @IBOutlet weak var departTextFiled: UITextField! {
        didSet {
            departTextFiled.inputView = UIView()
            departTextFiled.addAction(UIAction { [unowned self] _ in
                let alert = UIAlertController(title: "Select department", message: nil, preferredStyle: .actionSheet)
                let departments = fetchedResultsController.fetchedObjects
                for department in departments ?? [] {
                    alert.addAction(UIAlertAction(title: department.name, style: .default) { [unowned self] _ in
                        departTextFiled.text = department.name
                        departTextFiled.resignFirstResponder()
                    })
                }
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [unowned self] _ in
                    departTextFiled.resignFirstResponder()
                }))
                present(alert, animated: true)
            }, for: .editingDidBegin)
        }
    }
    @IBOutlet weak var commentTextField: UITextField!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let person = person {
            nameTextField.text = person.name
            ageTextFiled.text = String(person.age)
            departTextFiled.text = person.department
            commentTextField.text = person.comment?.text
        }
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if savePerson() {
            dismiss(animated: true)
        }
    }
    
    private func savePerson() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else {
            showWarning(forTextField: nameTextField, text: "Enter the name")
            return false
        }
        guard let age = Int16(ageTextFiled.text ?? "") else {
            showWarning(forTextField: ageTextFiled, text: "Enter the age")
            return false
        }
        guard let department = departTextFiled.text, !name.isEmpty else {
            showWarning(forTextField: departTextFiled, text: "Enter the department")
            return false
        }
        if person == nil {
            person = Person(name: name, age: age, department: department)
        } else {
            person?.name = name
            person?.age = age
            person?.department = department
            person?.comment = Comment(text: commentTextField.text)
        }
        CoreDataManager.shared.saveContext()
        return true
    }
    
    private func showWarning(forTextField tf: UITextField, text: String) {
        tf.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: #colorLiteral(red: 1, green: 0, blue: 0.1704175472, alpha: 1)])
    }
}
