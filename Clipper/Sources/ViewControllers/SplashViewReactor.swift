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
  let authService: AuthServiceType
  
  init(authService: AuthServiceType) {
    self.authService = authService
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .checkAuthenticated:
      return Observable
        .just(Mutation.setAuthenticated(authService.accessToken != nil))
        .delay(.seconds(2), scheduler: MainScheduler.instance)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setAuthenticated(let isAuthenticated):
      newState.isAuthenticated = isAuthenticated
    }
    return newState
  }
}
