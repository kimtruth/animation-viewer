//
//  APIServiceType.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 16..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

protocol APIServiceType {
}

extension APIServiceType {
  static func url(_ path: String) -> String {
    return "http://very.secret.url" + path
  }
}
