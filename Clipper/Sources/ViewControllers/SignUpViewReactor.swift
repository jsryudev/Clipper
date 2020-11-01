//
//  SignUpViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import UIKit

import ReactorKit

final class SignUpViewReactor: Reactor {
  enum Action {
    case signUp(String)
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
    case .signUp(_):
      return .empty()
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
