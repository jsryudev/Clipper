//
//  ClipperAPI.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/30.
//
import Foundation

import Moya

enum ClipperAPI {
  case signUp
  case me
}

extension ClipperAPI: TargetType {
  var baseURL: URL {
    return URL(string: "http://localhost:3000/api")!
  }

  var path: String {
    switch self {
    case .signUp:
      return "/users"
    case .me:
      return "/user"
    }
  }

  var method: Moya.Method {
    switch self {
    case .signUp:
      return .post
    case .me:
      return .get
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    return .requestPlain
  }

  var headers: [String : String]? {
    return [:]
  }
}
