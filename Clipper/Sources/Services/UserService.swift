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
  func signUp(token: String, name: String, type: UserType) -> Single<User>
  func authenticate(token: String) -> Single<Any>
}

final class UserService: UserServiceType {
  let provider: MoyaProvider<ClipperAPI>

  init(provider: MoyaProvider<ClipperAPI>) {
    self.provider = provider
  }

  func signUp(token: String, name: String, type: UserType = .google) -> Single<User> {
    return self.provider.rx
      .request(.signUp(token, name, type))
      .map(User.self)
  }

  func authenticate(token: String) -> Single<Any> {
    return self.provider.rx
      .request(.authenticate(token))
      .mapJSON()
    }
}
