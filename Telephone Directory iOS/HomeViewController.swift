//
//  HomeViewController.swift
//  Telephone Directory iOS
//
//  Created by Matteo Gazzato on 23/07/18.
//  Copyright © 2018 Matteo Gazzato. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: Outlets
  @IBOutlet weak var searchResultsTableView: UITableView!
  
  // MARK: Var and Constants
  static let EditEntrySegue = "EditEntrySegueIdentifier"
  static let AddNewEntrySegue = "AddNewEntrySegueIdentifier"
  
  // MARK: UI Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: UITabelView Delegate Methods
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let selectedCell = tableView.cellForRow(at: indexPath) {
      performSegue(withIdentifier: HomeViewController.EditEntrySegue, sender: selectedCell)
    }
  }
  
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

