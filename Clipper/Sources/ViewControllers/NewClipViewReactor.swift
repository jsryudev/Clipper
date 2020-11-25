//
//  NewClipViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/10.
//

import ReactorKit

final class NewClipViewReactor: Reactor {

  enum Action {
    case create
  }

  enum Mutation {
    case setSuccess(Bool)
  }

  struct State {
    let marker: Marker
    var isSuccess: Bool?
  }

  let initialState: State
  let markerService: MarkerServiceType

  init(marker: Marker, markerService: MarkerServiceType) {
    self.markerService = markerService
    self.initialState = State(marker: marker, isSuccess: nil)
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .create:
      if let id = currentState.marker.id {
        return self.markerService.createClip(
          marker: id,
          title: "foo",
          content: "bar"
        )
        .asObservable()
        .map { .setSuccess($0) }
      } else {
        return .empty()
      }
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setSuccess(let isSuccess):
      newState.isSuccess = isSuccess
    }
    return newState
  }
}
