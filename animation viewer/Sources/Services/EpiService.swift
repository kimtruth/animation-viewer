//
//  EpiService.swift
//  animation viewer
//
//  Created by Truth on 2018. 2. 17..
//  Copyright © 2018년 kimtruth. All rights reserved.
//

import Alamofire

struct EpiService: APIServiceType {
  static func info(key: String, completion: @escaping (DataResponse<Any>) -> Void) {
    let urlString = self.url("/anime/info/" + key)
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
