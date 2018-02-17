//
//  EpiListViewController.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 17..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import UIKit

final class EpiListViewController: UIViewController {

  private let tableView = UITableView().then {
    $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
}

// MARK: - UITableViewDelegate

extension EpiListViewController: UITableViewDelegate {
  
}

// MARK: - UITableViewDataSource

extension EpiListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    return cell
  }
}
