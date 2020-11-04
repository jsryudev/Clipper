//
//  GreetingViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import ReactorKit
import CoreLocation

final class GreetingViewReactor: Reactor {
  enum Action {
    case checkCurrentAuthorization
    case requestAuthorization
  }

  enum Mutation {
    case setCurrentAuthorization(AuthorizationType)
    case setChangedAuthorization(AuthorizationType)
  }

  struct State {
    let user: User
    var currentAuthorization: AuthorizationType?
    var changedAuthorization: AuthorizationType?
  }

  let initialState: State
  let locationService: LocationServiceType

  init(
    user: User,
    locationService: LocationServiceType
  ) {
    self.initialState = State(user: user)
    self.locationService = locationService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .checkCurrentAuthorization:
      return self.locationService
        .currentAuthorization()
        .map { Mutation.setCurrentAuthorization($0) }
        .debug()
    case .requestAuthorization:
      self.locationService.requestAuthorization()
      return self.locationService
        .didChangeAuthorization()
        .map { Mutation.setChangedAuthorization($0) }
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setCurrentAuthorization(let currentAuthorization):
      newState.currentAuthorization = currentAuthorization
    case .setChangedAuthorization(let changedAuthorization):
      newState.changedAuthorization = changedAuthorization
    }
    return newState
  }
}
