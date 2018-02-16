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
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 10
  }
  private let titleLabel = UILabel().then {
    $0.text = "테스트 제목"
    $0.font = .systemFont(ofSize: 13)
  }
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(imageView)
    self.addSubview(titleLabel)
    
    self.imageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.bottom.equalToSuperview().offset(-30)
    }
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.imageView.snp.bottom)
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
