//
//  SplashViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import ReactorKit
import RxCocoa
import RxSwift

final class SplashViewReactor: Reactor {
  enum Action {
    case checkAuthenticated
  }

  enum Mutation {
    case setAuthenticated(Bool)
  }

  struct State {
    var isAuthenticated: Bool?
  }

  let initialState = State()

  init() {
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .checkAuthenticated:
      return .empty()
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    return state
  }
}
