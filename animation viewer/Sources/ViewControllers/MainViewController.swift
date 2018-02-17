//
//  MainViewController.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 16..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

  // MARK: Properties
  
  private var aniDict: [Int: [AniInfo]] = [Int: [AniInfo]]()
  private var infos: [AniInfo] = []
  
  // MARK: UI
  
  private let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then {
      $0.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
  ).then {
    $0.backgroundColor = .white
    $0.register(AniCell.self, forCellWithReuseIdentifier: "aniCell")
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(named: "menu"),
      style: .plain,
      target: self,
      action: #selector(showMenu)
    )
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    self.view.addSubview(collectionView)
    
    self.collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    self.fetchInfo()
  }
  
  func fetchInfo() {
    AniService.info { response in
      switch response.result {
      case .failure(let error):
        print("Animation info load fail...")
        print(error)
        
      case .success(let value):
        guard let infoJSONArray = value as? [[String: Any]] else { return }
        self.infos = [AniInfo](JSONArray: infoJSONArray)
        self.aniDict = self.infos.reduce(into: [Int: [AniInfo]]()) {
          if $0[$1.year] == nil  {
            $0[$1.year] = []
          }
          $0[$1.year]?.append($1)
        }
        
        let recentYear = Array(self.aniDict.keys).max() ?? 0
        if let infos = self.aniDict[recentYear] {
          self.infos = infos
        }
        
        self.collectionView.reloadData()
      }
    }
  }
  
  @objc func showMenu() {
    let sideMenuViewController = SideMenuViewController()
    sideMenuViewController.years = Array(self.aniDict.keys).sorted(by: >)
    self.present(sideMenuViewController, animated: false, completion: nil)
  }
  
}

extension MainViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.infos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aniCell", for: indexPath) as! AniCell
    cell.configure(info: self.infos[indexPath.item])
    
    return cell
  }
  
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (self.view.width - 30) / 2
    let height = width / 16 * 9 + 30
    let size = CGSize(width: width, height: height)
    return size
  }
  
}

