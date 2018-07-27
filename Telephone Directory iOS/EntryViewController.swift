//
//  EntryViewController.swift
//  Telephone Directory iOS
//
//  Created by Matteo Gazzato on 24/07/18.
//  Copyright © 2018 Matteo Gazzato. All rights reserved.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  
  // MARK: Var and Constants
  public var editMode = false
  
  // MARK: UI Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    if !editMode {
      let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goToHomeWithoutSaving))
      self.navigationItem.leftBarButtonItem = cancelButton
    } 
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAndGoToHome))
    self.navigationItem.rightBarButtonItem = saveButton
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  @objc func goToHomeWithoutSaving() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func saveAndGoToHome() {
    // Check First Name and Last Name
    var validation = true
    validation = validation && validateFirstLastName()
    validation = validation && validatePhoneNumber()
    if validation {
      let newContact = Contact()
      newContact.firstName = firstNameTextField.text!
      newContact.lastName = lastNameTextField.text!
      newContact.telephoneNumber = phoneNumberTextField.text!
      let realm = try! Realm()
      try! realm.write {
        realm.add(newContact)
      }
      self.dismiss(animated: true, completion: nil)
    } else {
      let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
      let alertViewController = UIAlertController(title: "Warning", message: "Information must be in the correct format", preferredStyle: .alert)
      alertViewController.addAction(alertAction)
      self.present(alertViewController, animated: true, completion: nil)
    }
  }
  
  // MARK: Fields Validation
  private func validateFirstLastName() -> Bool {
    guard let firstName = firstNameTextField.text else {
      return false
    }
    guard let lastName = lastNameTextField.text else {
      return false
    }
    return firstName.count != 0 && lastName.count != 0
  }
  
  private func validatePhoneNumber() -> Bool {
    guard let phoneNumber = phoneNumberTextField.text else {
      return false
    }
    // "+" followed by a nonempty group of digits, a space, a nonempty group of digits, a space, a group of digits with at least 6 digits
    let phoneNumberPattern = "^\\+[0-9]{2} [0-9]{2} [0-9]{6,}$"
    if let phoneNumberRegex = try? NSRegularExpression(pattern: phoneNumberPattern, options: []) {
      let matches = phoneNumberRegex.numberOfMatches(in: phoneNumber, options: [], range: NSMakeRange(0, phoneNumber.count))
      if matches > 0 {
        return true
        }
      }
    return false
  }
}
