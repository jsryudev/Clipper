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
    case checkIfAuthenticated
  }

  enum Mutation {
  }

  struct State {
  }

  let initialState = State()

  init() {
  }

  func mutate(action: Action) -> Observable<Mutation> {
    return .empty()
  }

  func reduce(state: State, mutation: Mutation) -> State {
  }
}
