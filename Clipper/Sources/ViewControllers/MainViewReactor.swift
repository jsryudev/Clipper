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
    case checkIfAuthorized
  }

  enum Mutation {
    case setMe(User)
    case setHasAuthorized(Bool)
  }

  struct State {
    var user: User?
    var hasAuthorized: Bool?
  }

  let initialState = State()
  let userService: UserServiceType
  let locationService: LocationServiceType

  init(userService: UserServiceType, locationService: LocationService) {
    self.userService = userService
    self.locationService = locationService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    return userService.fetchMe()
      .asObservable()
      .map { .setMe($0) }
  }

  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    let hasAuthorizedMutation = self.locationService.authorization
      .observeOn(MainScheduler.asyncInstance)
      .compactMap { $0 }
      .flatMap { authorization -> Observable<Mutation> in
        .just(Mutation.setHasAuthorized(authorization == .authorized))
      }

    return Observable.merge(mutation, hasAuthorizedMutation)
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setMe(let user):
      newState.user = user
    case .setHasAuthorized(let hasAuthorized):
      newState.hasAuthorized = hasAuthorized
    }
    return newState
  }
}
