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
  let userService: UserServiceType

  init(userService: UserServiceType) {
    self.userService = userService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    return userService.fetchMe()
      .asObservable()
      .map { .setMe($0) }
      .debug()
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setMe(let user):
      newState.user = user
    }
    return newState
  }
}
