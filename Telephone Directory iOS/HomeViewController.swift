//
//  HomeViewController.swift
//  Telephone Directory iOS
//
//  Created by Matteo Gazzato on 23/07/18.
//  Copyright © 2018 Matteo Gazzato. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  // MARK: Outlets
  @IBOutlet weak var searchResultsTableView: UITableView!
  @IBOutlet weak var searchTextField: UITextField!
  
  
  // MARK: Var and Constants
  static let EditEntrySegue = "EditEntrySegueIdentifier"
  static let AddNewEntrySegue = "AddNewEntrySegueIdentifier"
  private var searchQueryFilter = ""
  private var searchFilteredResults = [Contact]()
  
  // MARK: UI Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    searchTextField.addTarget(self, action: #selector(setNewSearchQueryFromTextField(_:)), for: UIControlEvents.editingChanged)
    searchResultsTableView.tableFooterView = UIView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: Class Methods
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let selectedCell = tableView.cellForRow(at: indexPath) {
      performSegue(withIdentifier: HomeViewController.EditEntrySegue, sender: selectedCell)
    }
  }
  
  // MARK: UITextField Delegate Methods

  
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let entryNavigationViewController = segue.destination as! UINavigationController
    let entryViewController = entryNavigationViewController.viewControllers.first as! EntryViewController
    switch segue.identifier! {
    case HomeViewController.AddNewEntrySegue:
      entryViewController.editMode = false
    case HomeViewController.EditEntrySegue:
      entryViewController.editMode = true
    default:
      return
    }
  }
  
  
}

