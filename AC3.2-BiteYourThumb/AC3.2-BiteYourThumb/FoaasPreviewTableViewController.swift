//
//  FoaasPreviewTableViewController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasPreviewTableViewController: UITableViewController {
  
  internal var operation: FoaasOperation?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 100.0
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let fieldsCount = self.operation?.fields.count else {
      return 0
    }
    
    return fieldsCount + 1 // fields + the preview cell
  }
  
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell: UITableViewCell
    if indexPath.row == 0 {
      cell = tableView.dequeueReusableCell(withIdentifier: FoaasPreviewTextTableViewCell.cellIdentifier, for: indexPath) as! FoaasPreviewTextTableViewCell
      return cell
    }
    else {
      if let foaasCell = tableView.dequeueReusableCell(withIdentifier: FoaasFieldTableViewCell.cellIdentifier, for: indexPath) as? FoaasFieldTableViewCell {
        foaasCell.fieldNameLabel.text = self.operation?.fields[indexPath.row - 1].name
        foaasCell.fieldNameTextField.placeholder = self.operation?.fields[indexPath.row - 1].field
        return foaasCell
      }
    }
    
   return UITableViewCell()
   }
  
}
