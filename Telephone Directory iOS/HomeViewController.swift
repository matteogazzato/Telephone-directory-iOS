//
//  HomeViewController.swift
//  Telephone Directory iOS
//
//  Created by Matteo Gazzato on 23/07/18.
//  Copyright © 2018 Matteo Gazzato. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ContactTableViewCellDelegate {
  
  // MARK: Outlets
  @IBOutlet weak var searchResultsTableView: UITableView!
  @IBOutlet weak var searchTextField: UITextField!
  
  
  // MARK: Var and Constants
  static let EditEntrySegue = "EditEntrySegueIdentifier"
  static let EntrySegue = "EntrySegueIdentifier"
  private var searchQueryFilter = ""
  private var searchFilteredResults = [Contact]()
  private var selectedContactToEdit = Contact()
  
  // MARK: UI Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    searchTextField.addTarget(self, action: #selector(setNewSearchQueryFromTextField(_:)), for: UIControlEvents.editingChanged)
    searchResultsTableView.tableFooterView = UIView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
    searchResultsTableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: Class Methods
  @objc private func setNewSearchQueryFromTextField(_ textField: UITextField) {
    if let text = textField.text {
      searchQueryFilter = text
    } else {
      searchQueryFilter = ""
    }
    filterResults()
  }
  
  private func filterResults() {
    let query = "firstName contains[c] '\(searchQueryFilter)' OR lastName contains[c] '\(searchQueryFilter)' OR telephoneNumber contains[c] '\(searchQueryFilter)'"
    let realm = try! Realm()
    searchFilteredResults = Array(realm.objects(Contact.self).filter(query))
    searchResultsTableView.reloadData()
  }
  
  // MARK: UITabelView Delegate Methods
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let contactCell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.ContactTableViewCellIdentifier) as! ContactTableViewCell
    contactCell.delegate = self
    contactCell.indexPath = indexPath
    let contact = searchFilteredResults[indexPath.row]
    contactCell.fullNameLabel.text = "\(contact.firstName) - \(contact.lastName)"
    contactCell.telephoneNumberLabel.text = contact.telephoneNumber
    return contactCell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchFilteredResults.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 125.0
  }
  
  
  
  // MARK: UITextField Delegate Methods
  
  // MARK: ContactTableViewCell Delegate Methods
  func editContactAtIndexPath(_ indexPath: IndexPath) {
    selectedContactToEdit = searchFilteredResults[indexPath.row]
    performSegue(withIdentifier: HomeViewController.EntrySegue, sender: nil)
  }
  
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier! {
    case HomeViewController.EntrySegue:
      let entryNavigationViewController = segue.destination as! UINavigationController
      let entryViewController = entryNavigationViewController.viewControllers.first as! EntryViewController
      if let _ = sender {
        entryViewController.editMode = false
      } else {
        entryViewController.editMode = true
        entryViewController.contact = selectedContactToEdit
      }
    default:
      return
    }
  }
  
  
}

