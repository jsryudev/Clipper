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
    case signIn(String)
  }

  enum Mutation {
    case setSignIn(Bool)
  }

  struct State {
    var isSignIn: Bool?
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
    case .signIn(let token):
      return userService.signIn(token: token)
        .do(
          onSuccess: { [weak self] user in
            self?.authService.save(token: user.accessToken)
        })
        .asObservable()
        .map { _ in true }
        .catchErrorJustReturn(false)
        .map { .setSignIn($0) }
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setSignIn(let isSignIn):
      newState.isSignIn = isSignIn
    }
    return newState
  }
}
