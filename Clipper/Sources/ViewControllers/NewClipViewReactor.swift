//
//  NewClipViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/10.
//

import ReactorKit

final class NewClipViewReactor: Reactor {

  enum Action {
    case done
    case title(String)
    case content(String)
    case dismiss
  }

  enum Mutation {
    case setTitle(String)
    case setContent(String)
    case setDismissed(Bool)
  }

  struct State {
    let marker: Marker
    var title: String
    var content: String
    var isDismissed: Bool
  }

  let initialState: State
  let markerService: MarkerServiceType

  init(marker: Marker, markerService: MarkerServiceType) {
    self.markerService = markerService
    self.initialState = State(marker: marker, title: "", content: "", isDismissed: false)
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .done:
      let create: Single<Bool>

      if let id = currentState.marker.id {
       create = self.markerService.createClip(
          marker: id,
          title: currentState.title,
          content: currentState.content
        )
      }

      // id 없는 경우 처리

      return create
        .asObservable()
        .map { .setDismissed($0) }

    case .title(let title):
      return .just(.setTitle(title))

    case .content(let content):
      return .just(.setContent(content))

    case .dismiss:
      return .just(.setDismissed(true))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setTitle(let title):
      newState.title = title
    case .setContent(let content):
      newState.content = content
    case .setDismissed(let isDismissed):
      newState.isDismissed = isDismissed
    }
    return newState
  }
}
