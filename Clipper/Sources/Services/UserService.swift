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

protocol UserServiceType {
  func signIn(token: String) -> Single<User>
}

final class UserService: UserServiceType {
  let provider: MoyaProvider<ClipperAPI>

  init(provider: MoyaProvider<ClipperAPI>) {
    self.provider = provider
  }

  func signIn(token: String) -> Single<User> {
    return self.provider.rx
      .request(.signIn(token))
      .map(User.self)
    }
}
