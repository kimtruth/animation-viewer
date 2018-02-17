//
//  Episode.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 17..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import ObjectMapper

struct Episode: Mappable {
  
  var result: String!
  var data: [String]!
  var anime: String!
  
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    result <- map["result"]
    data <- map["data"]
    anime <- map["anime"]
  }
}
