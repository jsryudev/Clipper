//
//  ClipperAPI.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/30.
//
import Foundation

import Moya

enum ClipperAPI {
  case signIn(String)
  case signUp
}

extension ClipperAPI: TargetType {
  var baseURL: URL {
    return URL(string: "http://localhost:3000/api")!
  }

  var path: String {
    switch self {
    case .signIn:
      return "/user/google-login"
    case .signUp:
      return "/user"
    }
  }

  var method: Moya.Method {
    switch self {
    case .signUp:
      return .get
    case .signIn:
      return .post
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
    case .signIn(let token):
      return .requestJSONEncodable(["token": token])
    default:
      return .requestPlain
    }
  }

  var headers: [String : String]? {
    return [:]
  }
}
