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
    case setMarkers([Marker])
  }

  struct State {
    var user: User?
    var hasAuthorized: Bool?
    var markers: [Marker]
  }

  let initialState = State(markers: [])
  let userService: UserServiceType
  let locationService: LocationServiceType
  let markerService: MarkerServiceType

  init(
    userService: UserServiceType,
    locationService: LocationServiceType,
    markerService: MarkerServiceType
  ) {
    self.userService = userService
    self.locationService = locationService
    self.markerService = markerService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .fetchMe:
      return userService.fetchMe()
        .asObservable()
        .map { .setMe($0) }
    case .fetchNearbyClips(let lat, let lng):
      return markerService
        .fetchNearby(latitude: lat, longitude: lng)
        .asObservable()
        .map { .setMarkers($0) }
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
    case .setMarkers(let markers):
      newState.markers = markers
    }
    return newState
  }
}
