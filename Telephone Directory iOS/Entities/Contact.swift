//
//  Contact.swift
//  Telephone Directory iOS
//
//  Created by Matteo Gazzato on 27/07/18.
//  Copyright © 2018 Matteo Gazzato. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
  @objc dynamic var firstName = ""
  @objc dynamic var lastName = ""
  @objc dynamic var telephoneNumber = ""
}
