//
//  ClipperAPI.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/30.
//
import Foundation

import Moya

enum ClipperAPI {
  case signUp(String, String, UserType)
  case authenticate(String)
  case fetchMe

  case fetchNearMarkers(Double, Double)
  case fetchClips(String, Int, Int)
}

extension ClipperAPI: TargetType {
  var baseURL: URL {
    return URL(string: "http://localhost:3000/api")!
  }

  var path: String {
    switch self {
    case .signUp, .fetchMe:
      return "/user"
    case .authenticate:
      return "/user/google-login"
    case .fetchNearMarkers:
      return "/markers/near"
    case .fetchClips(let id, _, _):
      return "/markers/\(id)/clips"
    }
  }

  var method: Moya.Method {
    switch self {
    case .signUp, .authenticate:
      return .post
    case .fetchMe, .fetchNearMarkers, .fetchClips:
      return .get
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
    case .signUp(let token, let name, let type):
      return .requestJSONEncodable(
        [
          "type": type.rawValue,
          "token": token,
          "name": name
        ]
      )
    case .authenticate(let token):
      return .requestJSONEncodable(
        ["token": token]
      )
    case .fetchMe:
      return .requestPlain
    case .fetchNearMarkers(let lat, let lng):
      return .requestParameters(
        parameters: [
          "lng": lng,
          "lat": lat,
          "offset": 1000
        ],
        encoding: URLEncoding.queryString
      )
    case .fetchClips(_, let page, let limit):
      return .requestParameters(
        parameters: [
          "page": page,
          "limit": limit
        ],
        encoding: URLEncoding.queryString
      )
    }
  }

  var headers: [String : String]? {
    return [:]
  }
}
