//
//  ContactTableViewCell.swift
//  Telephone Directory iOS
//
//  Created by Matteo Gazzato on 29/07/18.
//  Copyright © 2018 Matteo Gazzato. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
  
  // MARK: Outlets
  
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var telephoneNumberLabel: UILabel!
  
  // MARK: Var and Constants
  static let ContactTableViewCellIdentifier = "ContactTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
