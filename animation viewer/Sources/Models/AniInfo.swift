//
//  AniInfo.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 16..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import ObjectMapper

struct AniInfo: Mappable {
  
  var key: String!
  var season: Int!
  var title: String!
  var year: Int!
  
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    self.key <- map["key"]
    self.season <- map["season"]
    self.title <- map["key"]
    self.year <- map["year"]
  }
}
