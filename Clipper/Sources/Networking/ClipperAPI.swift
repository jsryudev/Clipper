//
//  ClipperAPI.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/30.
//
import Foundation

import Moya
import MoyaSugar

enum ClipperAPI {
  case signUp(String, String, UserType)
  case authenticate(String)
  case fetchMe

  case fetchNearMarkers(Double, Double)
  case fetchClips(String, Int, Int)

  case createClipOfMarker(String, String, String)
}

extension ClipperAPI: SugarTargetType {
  var baseURL: URL {
    return URL(string: "http://localhost:3000/api")!
  }

  var route: Route {
    switch self {
    case .fetchMe:
      return .get("/user")
    case .signUp:
      return .post("/user")
    case .authenticate:
      return .get("/user/google-login")
    case .fetchNearMarkers:
      return .get("/markers/near")
    case .fetchClips(let id, _, _):
      return .get("/markers/\(id)/clips")
    case .createClipOfMarker(let id, _, _):
      return .post("/markers/\(id)/clips")
    }
  }

  var parameters: Parameters? {
    switch self {
    case .signUp(let token, let name, let type):
      return JSONEncoding() => [
        "type": type.rawValue,
        "token": token,
        "name": name
      ]

    case .authenticate(let token):
      return JSONEncoding() => [
        "token": token
      ]

    case .fetchNearMarkers(let latitude, let longitude):
      return URLEncoding.queryString => [
        "lng": longitude,
        "lat": latitude,
        "offset": 1000
      ]

    case .fetchClips(_, let page, let limit):
      return URLEncoding.queryString => [
        "page": page,
        "limit": limit
      ]

    case .createClipOfMarker(_, let title, let content):
      return JSONEncoding() => [
        "title": title,
        "content": content
      ]

    default: return nil
    }
  }

  var headers: [String : String]? {
    return ["Accept": "application/json"]
  }

  var sampleData: Data {
    return Data()
  }
}
