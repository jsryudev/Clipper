//
//  MarkerViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import ReactorKit

final class MarkerViewReactor: Reactor {

  enum Action {
    case configure
  }

  enum Mutation {
    case configureSections([MarkerViewSection])
  }

  struct State {
    let marker: Marker
    var sections: [MarkerViewSection] = []

    init(marker: Marker, sections: [MarkerViewSection]) {
      self.marker = marker
      self.sections = sections
    }
  }

  let initialState: State
  let clipService: ClipServiceType
  let markerViewItemCellReactorFactory: (ClipItem) -> MarkerViewItemCellReactor

  init(
    marker: Marker,
    clipService: ClipServiceType,
    markerViewItemCellReactorFactory: @escaping (ClipItem) -> MarkerViewItemCellReactor
  ) {
    self.clipService = clipService
    self.markerViewItemCellReactorFactory = markerViewItemCellReactorFactory
    let defalutSection = MarkerViewSection.action("기능", [.action])
    self.initialState = State(marker: marker, sections: [defalutSection])
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .configure:
      return .empty()
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .configureSections(let sections):
      _ = sections
    }
    return newState
  }

  private func markerViewSectionItems(with clips: [ClipItem]) -> [MarkerViewSectionItem] {
    return clips
      .map(self.markerViewItemCellReactorFactory)
      .map(MarkerViewSectionItem.clip)
  }
}
