//
//  AddPersonViewController.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 10.07.2022.
//

import UIKit

class AddPersonViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextFiled: UITextField!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let person = person {
            nameTextField.text = person.name
            ageTextFiled.text = String(person.age)
        }
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
            nameTextField.attributedPlaceholder = NSAttributedString(
                string: "Enter the name",
                attributes: [.foregroundColor: #colorLiteral(red: 1, green: 0, blue: 0.1704175472, alpha: 1)])
            return false
        }
        
        guard let age = Int16(ageTextFiled.text ?? "") else {
            ageTextFiled.attributedPlaceholder = NSAttributedString(
                string: "Enter the age",
                attributes: [.foregroundColor: #colorLiteral(red: 1, green: 0, blue: 0.1704175472, alpha: 1)])
            return false
        }
        if person == nil {
            person = Person(name: name, age: age)
        } else {
            person?.name = name
            person?.age = age
        }
        CoreDataManager.shared.saveContext()
        return true
    }
}
