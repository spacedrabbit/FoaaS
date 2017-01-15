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
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 64.0
    self.tableView.register(FoaasOperationsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    
    // TODO: make better use of this nav subclass or remove it entirely 
    if let foaasNavVC = self.navigationController as? FoaasNavigationController {
      foaasNavVC.adjustRightBar(to: .done)
      foaasNavVC.isNavigationBarHidden = true 
    }
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
    
    guard let operationCell = cell as? FoaasOperationsTableViewCell else {
      cell.textLabel?.text = "INVALID"
      return cell }
    operationCell.operationNameLabel.text = operations?[indexPath.row].name

    return operationCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard
      let selectedOperation = operations?[indexPath.row],
      let navVC = self.navigationController
    else { return }
    
    let dtvc = FoaasPrevewViewController()
    dtvc.set(operation: selectedOperation)
    navVC.pushViewController(dtvc, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard
      let identifier = segue.identifier,
      identifier == "FoaasPreviewSegue",
      segue.destination is FoaasPrevewViewController,
      let senderCell = sender as? UITableViewCell,
      let cellIndex = self.tableView.indexPath(for: senderCell) else {
        return
    }
    
    (segue.destination as! FoaasPrevewViewController).set(operation: (self.operations?[cellIndex.row]))
  }
  
}
