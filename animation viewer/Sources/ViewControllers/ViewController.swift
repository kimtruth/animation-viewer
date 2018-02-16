//
//  ViewController.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 16..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

  // MARK: UI
  
  private let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
    $0.backgroundColor = .gray
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    self.view.addSubview(collectionView)
    
    self.collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
}

extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
  
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  
}

