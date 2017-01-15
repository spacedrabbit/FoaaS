//
//  FoaasOperationsTableViewController.swift
//  AC3.2-BiteYourThumb
//
//  Created by Louis Tur on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FoaasOperationsTableViewCell: UITableViewCell {
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    let _ = [ operationNameLabel ].map{ $0.translatesAutoresizingMaskIntoConstraints = false }
    
    var _ = [
      self.contentView.heightAnchor.constraint(equalToConstant: 64.0),
      self.operationNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0),
      self.operationNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
    ].map{ $0.isActive = true }
  }
  
  private func setupViewHierarchy() {
    self.contentView.addSubview(operationNameLabel)
  }
  
  
  // MARK: Lazy Inits
  internal lazy var operationNameLabel: UILabel = {
    let label: UILabel = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 28.0)
    return label
  }()
  
}

class FoaasOperationsTableViewController: UITableViewController {
  
  let operations = FoaasDataManager.shared.operations
  let cellIdentifier = "FoaasOperationCellIdentifier"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Operations"
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 64.0
    self.tableView.register(FoaasOperationsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    
    if let foaasNavVC = self.navigationController as? FoaasNavigationController {
      foaasNavVC.adjustRightBar(to: .done)
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
