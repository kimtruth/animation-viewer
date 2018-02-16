//
//  AniService.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 16..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import Alamofire

struct AniService: APIServiceType {
  static func info(completion: @escaping (DataResponse<Any>) -> Void) {
    let urlString = self.url("/json")
    let headers = [
      "Accept": "application/json"
    ]
    
    Alamofire
      .request(urlString, headers: headers)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        completion(response)
    }
  }
}
