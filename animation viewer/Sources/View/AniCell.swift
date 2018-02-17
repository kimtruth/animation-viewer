//
//  AniCell.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 16..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import UIKit

import Kingfisher

final class AniCell: UICollectionViewCell {
  
  // MARK: UI
  private let imageShadowView = UIView().then {
    $0.layer.shadowOffset = .zero
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = 0.25
    $0.layer.shadowRadius = 3.0
  }
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
    
    self.imageShadowView.addSubview(imageView)
    self.addSubview(self.imageShadowView)
    self.addSubview(self.titleLabel)
    
    self.imageShadowView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.bottom.equalToSuperview().offset(-30)
    }
    self.imageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.imageView.snp.bottom)
      make.left.equalTo(10)
      make.right.bottom.equalToSuperview()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: Configuring
  
  func configure(info: AniInfo) {
    self.titleLabel.text = info.desc
    if let key = info.key, let url = URL(string: "http://very.secret.url/assets/img/\(key).png") {
      self.imageView.kf.setImage(with: url)
    }
    
  }
  
}
