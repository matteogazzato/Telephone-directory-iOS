//
//  EntryViewController.swift
//  Telephone Directory iOS
//
//  Created by Matteo Gazzato on 24/07/18.
//  Copyright © 2018 Matteo Gazzato. All rights reserved.
//

import UIKit
import RealmSwift
import ContactsUI

class EntryViewController: UIViewController, CNContactPickerDelegate {
  
  // MARK: Outlets
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  
  // MARK: Var and Constants
  var editMode = false
  var contact = Contact()
  
  // MARK: UI Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if editMode {
      firstNameTextField.text = contact.firstName
      lastNameTextField.text = contact.lastName
      phoneNumberTextField.text = contact.telephoneNumber
    }
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goToHomeWithoutSaving))
    self.navigationItem.leftBarButtonItem = cancelButton
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
  
  // MARK: Class Methods
  @objc func saveAndGoToHome() {
    // Check First Name and Last Name
    var validation = true
    validation = validation && validateFirstLastName()
    validation = validation && validatePhoneNumber()
    if validation {
      let realm = try! Realm()
      if editMode {
        // Edit existing Contact
        try! realm.write {
          contact.firstName = firstNameTextField.text!
          contact.lastName = lastNameTextField.text!
          contact.telephoneNumber = phoneNumberTextField.text!
        }
      } else {
        // New Contact
        contact.firstName = firstNameTextField.text!
        contact.lastName = lastNameTextField.text!
        contact.telephoneNumber = phoneNumberTextField.text!
        try! realm.write {
          realm.add(contact)
        }
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
  
  // MARK: Actions
  @IBAction func importNewContactFromContacts(_ sender: Any) {
    let contactPicker = CNContactPickerViewController()
    contactPicker.delegate = self
    contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
    self.present(contactPicker, animated: true, completion: nil)
  }
  
  //MARK: CNContactPicker Delegate Methods
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
    firstNameTextField.text = contactProperty.contact.givenName
    lastNameTextField.text = contactProperty.contact.familyName
    let phoneNumber = contactProperty.value as! CNPhoneNumber
    phoneNumberTextField.text = phoneNumber.stringValue
  }  
}
