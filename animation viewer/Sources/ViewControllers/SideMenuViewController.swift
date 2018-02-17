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
    
    self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.0)
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.width.equalTo(130)
      make.left.equalTo(-130)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tableViewOpen()
  }
  
  func tableViewOpen() {
    self.tableView.snp.updateConstraints { make in
      make.left.equalTo(0)
    }
    
    UIView.animate(withDuration: 0.25) {
      self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.2)
      self.view.layoutIfNeeded()
    }
  }
  
  func tableViewClose(completion: (() -> Void)?) {
    self.tableView.snp.updateConstraints { make in
      make.left.equalTo(-130)
    }
    UIView.animate(withDuration: 0.25, animations: {
      self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.0)
      self.view.layoutIfNeeded()
    }) { (finished) in
      completion?()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.tableViewClose() {
      self.dismiss(animated: false, completion: nil)
    }
  }
  
}

// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    let year = cell?.tag ?? 0
    
    self.select?(year)
    self.tableViewClose() {
      self.dismiss(animated: false, completion: nil)
    }
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
