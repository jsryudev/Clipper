//
//  UserService.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/30.
//

import Foundation

import Moya
import RxMoya
import RxSwift

typealias JSON = [String: String]

protocol UserServiceType {
  func authenticate(token: String) -> Single<Any>
}

final class UserService: UserServiceType {
  let provider: MoyaProvider<ClipperAPI>

  init(provider: MoyaProvider<ClipperAPI>) {
    self.provider = provider
  }

  func authenticate(token: String) -> Single<Any> {
    return self.provider.rx
      .request(.authenticate(token))
      .mapJSON()
    }
}
