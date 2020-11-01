//
//  SignInViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/29.
//

import UIKit

import ReactorKit
import Moya

final class SignInViewReactor: Reactor {
  enum Action {
    case authenticate(String)
  }

  enum Mutation {
    case setSuccess(Bool)
  }

  struct State {
    var isSuccess: Bool?
  }

  let initialState = State()
  let userService: UserServiceType
  let authService: AuthServiceType

  init(userService: UserServiceType, authService: AuthServiceType) {
    self.userService = userService
    self.authService = authService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .authenticate(let token):
      return userService.authenticate(token: token)
        .do(onSuccess: { [weak self] data in
            guard let json = data as? [String: Any] else {
              return
            }
            self?.authService.save(token: json["accessToken"] as? String)
          })
        .do(
          onError: { _ in
          // handle error
        })
        .asObservable()
        .map { _ in true }
        .catchErrorJustReturn(false)
        .map { .setSuccess($0) }
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setSuccess(let isSuccess):
      newState.isSuccess = isSuccess
    }
    return newState
  }
}
