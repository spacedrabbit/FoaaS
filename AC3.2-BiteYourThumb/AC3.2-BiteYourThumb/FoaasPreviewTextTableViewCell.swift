//
//  FoaasPreviewTextTableViewCell.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasPreviewTextTableViewCell: UITableViewCell {
  internal static let cellIdentifier: String = "FoaasPreviewCellIdentifier"
  @IBOutlet weak var previewTextField: UITextView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}
