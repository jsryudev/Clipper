//
//  GreetingViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import CoreLocation

import ReactorKit

final class GreetingViewReactor: Reactor {
  enum Action {
    case checkCurrentAuthorization
    case authorizationAction(AuthorizationType)
  }
  
  enum Mutation {
    case setAuthorization(AuthorizationType)
  }
  
  struct State {
    let user: User
    var authorization: AuthorizationType?
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
        .map { Mutation.setAuthorization($0) }
      
    case .authorizationAction(let type):
      if case .notDetermined = type {
        self.locationService.requestAuthorization()
        return self.locationService
          .didChangeAuthorization()
          .map { Mutation.setAuthorization($0) }
      } else {
        return .empty()
      }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setAuthorization(let authorization):
      newState.authorization = authorization
    }
    return newState
  }
}
