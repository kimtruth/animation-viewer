//
//  EpiListViewController.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 17..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import UIKit

final class EpiListViewController: UIViewController {

  // MARK: Properties
  
  var info: AniInfo?
  private var episodes: [String] = []
  
  // MARK: UI
  
  private let tableView = UITableView().then {
    $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.view.addSubview(self.tableView)
    
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    if let key = self.info?.key {
      EpiService.info(key: key) { response in
        switch response.result {
        case .failure(let error):
          print("Episode load error..")
          print(error)
        case .success(let value):
          guard let JSON = value as? [String: Any] else { return }
          guard let data = Episode(JSON: JSON)?.data else { return }
          self.episodes = data
          self.tableView.reloadData()
        }
      }
    }
  }
  
}

// MARK: - UITableViewDelegate

extension EpiListViewController: UITableViewDelegate {
  
}

// MARK: - UITableViewDataSource

extension EpiListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return episodes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    cell.textLabel?.text = "\(indexPath.item + 1) 화"
    
    return cell
  }
}
