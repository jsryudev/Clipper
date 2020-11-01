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
    case signUp
    case typeName(String)
  }

  enum Mutation {
    case setSuccess(Bool)
    case setName(String)
  }

  struct State {
    let token: String
    var isSuccess: TrackedValue<Bool>?
    var name: String?
  }

  let initialState: State
  let userService: UserServiceType
  let authService: AuthServiceType

  init(
    userService: UserServiceType,
    authService: AuthServiceType,
    token: String
  ) {
    self.initialState = State(token: token)
    self.userService = userService
    self.authService = authService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .typeName(let name):
      return Observable.just(.setName(name))
    case .signUp:
      return userService.signUp(
        token: currentState.token,
        name: currentState.name ?? "",
        type: .google
      )
      .do(
        onSuccess: { [weak self] user in
          self?.authService.save(token: user.accessToken)
        },
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
    case .setName(let name):
      newState.name = name
    case .setSuccess(let isSuccess):
      newState.isSuccess = TrackedValue<Bool>(
        tracker: (state.isSuccess?.tracker ?? 0) + 1,
        value: isSuccess
      )
    }
    return newState
  }
}
