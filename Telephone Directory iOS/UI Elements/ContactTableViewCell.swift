//
//  ContactTableViewCell.swift
//  Telephone Directory iOS
//
//  Created by Matteo Gazzato on 29/07/18.
//  Copyright © 2018 Matteo Gazzato. All rights reserved.
//

import UIKit

protocol ContactTableViewCellDelegate {
  func editContactAtIndexPath(_ indexPath: IndexPath)
}

class ContactTableViewCell: UITableViewCell {
  
  // MARK: Outlets
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var telephoneNumberLabel: UILabel!
  
  // MARK: Var and Constants
  static let ContactTableViewCellIdentifier = "ContactTableViewCell"
  var delegate: ContactTableViewCellDelegate!
  var indexPath: IndexPath!
  
  // MARK: UI Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  //MARK: Class Methods
  @IBAction func editContactAction(_ sender: UIButton) {
    self.delegate.editContactAtIndexPath(indexPath)
  }
}
