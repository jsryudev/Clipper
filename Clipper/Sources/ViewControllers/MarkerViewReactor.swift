//
//  ClipViewReactor.swift
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
    case configureSections([ClipViewSection])
  }

  struct State {
    let marker: Marker
    var sections: [ClipViewSection] = []

    init(marker: Marker, sections: [ClipViewSection]) {
      self.marker = marker
      self.sections = sections
    }
  }

  let initialState: State
  let clipService: ClipServiceType
  let clipViewItemCellReactorFactory: (ClipItem) -> ClipViewItemCellReactor

  init(
    marker: Marker,
    clipService: ClipServiceType,
    clipViewItemCellReactorFactory: @escaping (ClipItem) -> ClipViewItemCellReactor
  ) {
    self.clipService = clipService
    self.clipViewItemCellReactorFactory = clipViewItemCellReactorFactory
    let defalutSection = ClipViewSection.action("기능", [.action])
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

  private func clipViewSectionItems(with clips: [ClipItem]) -> [ClipViewSectionItem] {
    return clips
      .map(self.clipViewItemCellReactorFactory)
      .map(ClipViewSectionItem.clip)
  }
}
