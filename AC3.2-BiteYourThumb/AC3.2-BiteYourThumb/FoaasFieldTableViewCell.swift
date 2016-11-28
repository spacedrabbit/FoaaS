//
//  FoaasFieldTableViewCell.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasFieldTableViewCell: UITableViewCell {
  internal static let cellIdentifier: String = "FoaasFieldCellIdentifier"
  
  @IBOutlet weak var fieldNameLabel: UILabel!
  @IBOutlet weak var fieldNameTextField: UITextField!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
