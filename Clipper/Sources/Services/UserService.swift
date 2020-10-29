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
  func signIn(token: String) -> Single<Bool>
}

final class UserService: UserServiceType {
  let provider: MoyaProvider<ClipperAPI>

  init(provider: MoyaProvider<ClipperAPI>) {
    self.provider = provider
  }

  func signIn(token: String) -> Single<Bool> {
    return self.provider.rx
      .request(.signIn(token))
      .map(User.self)
      .do(
        onSuccess: { user in
          // access token keychain 저장
      })
      .map { _ in true }
      .catchErrorJustReturn(false)
    }
}
