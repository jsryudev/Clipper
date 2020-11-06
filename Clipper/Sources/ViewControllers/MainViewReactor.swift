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
    case fetchNearbyClips(Double, Double)
  }

  enum Mutation {
    case setMe(User)
    case setHasAuthorized(Bool)
    case setClips([Clip])
  }

  struct State {
    var user: User?
    var hasAuthorized: Bool?
    var clips: [Clip]
  }

  let initialState = State(clips: [])
  let userService: UserServiceType
  let locationService: LocationServiceType
  let clipService: ClipServiceType

  init(
    userService: UserServiceType,
    locationService: LocationServiceType,
    clipService: ClipServiceType
  ) {
    self.userService = userService
    self.locationService = locationService
    self.clipService = clipService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .fetchMe:
      return userService.fetchMe()
        .asObservable()
        .map { .setMe($0) }
    case .fetchNearbyClips(let lat, let lng):
      return clipService
        .fetchNearby(latitude: lat, longitude: lng)
        .asObservable()
        .map { .setClips($0) }
    }
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
    case .setClips(let clips):
      newState.clips = clips
    }
    return newState
  }
}
