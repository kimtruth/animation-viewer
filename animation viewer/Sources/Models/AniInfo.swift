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
  var desc: String {
    get{
      guard let season = self.season else { return "" }
      guard let title = self.title else { return "" }
      return "[\(season)분기] \(title)"
    }
  }
  
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    self.key <- map["key"]
    self.season <- map["season"]
    self.title <- map["value"]
    self.year <- map["year"]
  }
  
  static func <(lhs: AniInfo, rhs: AniInfo) -> Bool {
    if lhs.season == rhs.season {
      return lhs.title < rhs.title
    }
    return lhs.season < rhs.season
  }
}
