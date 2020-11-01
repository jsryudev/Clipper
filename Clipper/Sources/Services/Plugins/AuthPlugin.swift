//
//  AuthPlugin.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import Foundation

import Moya

struct AuthPlugin: PluginType {
  fileprivate let authService: AuthServiceType

  init(authService: AuthServiceType) {
    self.authService = authService
  }

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    if let accessToken = self.authService.accessToken {
      request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
    return request
  }
}
