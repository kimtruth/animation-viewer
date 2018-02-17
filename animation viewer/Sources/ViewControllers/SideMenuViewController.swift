//
//  SideMenuViewController.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 17..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import UIKit

final class SideMenuViewController: UIViewController {
  
  // MARK: UI
  
  private let tableView = UITableView(frame: .zero).then {
    $0.backgroundColor = .white
    $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
  
}

// MARK: - UITableViewDataSource

extension SideMenuViewController: UITableViewDataSource {
  
}
