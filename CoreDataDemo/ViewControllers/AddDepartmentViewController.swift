//
//  AddDepartmentViewController.swift
//  CoreDataDemo
//
//  Created by Евгений Бияк on 11.07.2022.
//

import UIKit

class AddDepartmentViewController: UIViewController {

    @IBOutlet weak var depTextField: UITextField!
    
    var department: Department?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let department = department {
            depTextField.text = department.name
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if saveDepartment() {
            dismiss(animated: true)
        }
    }
    
    private func saveDepartment() -> Bool {
        guard let name = depTextField.text, !name.isEmpty else {
            depTextField.attributedPlaceholder = NSAttributedString(
                string: "Enter the department name",
                attributes: [.foregroundColor: #colorLiteral(red: 1, green: 0, blue: 0.1704175472, alpha: 1)])
            return false
        }
        if department == nil {
            department = Department(name: name)
        } else {
            department?.name = name
        }
        CoreDataManager.shared.saveContext()
        return true
    }
}
