//
//  AniCell.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 16..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import UIKit

final class AniCell: UICollectionViewCell {
  
  // MARK: UI
  private let imageView = UIImageView().then {
    $0.backgroundColor = .lightGray
  }
  private let titleLabel = UILabel().then {
    $0.text = "UI 테스트 제목"
  }
  
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(imageView)
    self.addSubview(titleLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
