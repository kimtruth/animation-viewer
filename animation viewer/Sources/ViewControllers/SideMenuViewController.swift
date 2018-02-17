//
//  SideMenuViewController.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 17..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import UIKit

final class SideMenuViewController: UIViewController {
  
  // MARK: Properties
  
  var years: [Int]?
  var select: ((Int) -> Void)?
  
  // MARK: UI
  
  private let tableView = UITableView(frame: .zero).then {
    $0.backgroundColor = .white
    $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    $0.tableFooterView = UIView(frame: .zero)
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints { make in
      make.top.left.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.4)
    }
  }
  
}

// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    let year = cell?.tag ?? 0
    
    select?(year)
    self.dismiss(animated: false, completion: nil)
  }
}

// MARK: - UITableViewDataSource

extension SideMenuViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return years?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let year = years?[indexPath.row] ?? 0
    
    cell.tag = year
    cell.textLabel?.text = String(year)
    return cell
  }
  
}
