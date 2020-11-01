//
//  MainViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import ReactorKit
import RxCocoa
import RxSwift

final class MainViewReactor: Reactor {
  enum Action {
    case fetchMe
  }

  enum Mutation {
    case setMe(User)
  }

  struct State {
    var user: User?
  }

  let initialState = State()

  init() {
  }

  func mutate(action: Action) -> Observable<Mutation> {
    return .empty()
  }

  func reduce(state: State, mutation: Mutation) -> State {
    return state
  }
}
