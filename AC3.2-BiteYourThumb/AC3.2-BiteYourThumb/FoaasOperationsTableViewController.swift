//
//  FoaasOperationsTableViewController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasOperationsTableViewController: UITableViewController {
  
  let operations = FoaasDataManager.shared.operations
  let cellIdentifier = "FoaasOperationCellIdentifier"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Operations"
    
    if let foaasNavVC = self.navigationController as? FoaasNavigationController {
      foaasNavVC.adjustRightBar(to: .done)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return operations?.count ?? 0
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel?.text = operations?[indexPath.row].name
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard
      let identifier = segue.identifier,
      identifier == "FoaasPreviewSegue",
      segue.destination is FoaasPreviewTableViewController,
      let senderCell = sender as? UITableViewCell,
      let cellIndex = self.tableView.indexPath(for: senderCell) else {
        return
    }
    
    (segue.destination as! FoaasPreviewTableViewController).operation = self.operations?[cellIndex.row]
  }
  
}
