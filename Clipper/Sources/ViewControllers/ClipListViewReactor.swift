//
//  ClipListViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/28.
//

import ReactorKit

final class ClipListViewReactor: Reactor {
  
  enum Action {
    case refresh
  }
  
  enum Mutation {
    case setClips([Clip])
  }
  
  struct State {
    let markerID: String
    var sections: [ClipListViewSection]
  }
  
  let initialState: State
  let clipService: ClipServiceType
  let clipCellReactorFactory: (Clip) -> ClipCellReactor
  
  init(
    marker id: String,
    clipService: ClipServiceType,
    clipCellReactorFactory: @escaping (Clip) -> ClipCellReactor
  ) {
    self.clipService = clipService
    self.clipCellReactorFactory = clipCellReactorFactory
    self.initialState = State(markerID: id, sections: [])
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .refresh:
      return self.clipService
        .fetchClips(
          marker: currentState.markerID,
          page: 0,
          limit: 0
        )
        .asObservable()
        .map { .setClips($0) }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setClips(let clips):
      let items =  self.clipSectionItems(with: clips)
      newState.sections = [.clip(items)]
    }
    return newState
  }
  
  private func clipSectionItems(with clips: [Clip]) -> [ClipListViewSectionItem] {
    return clips
      .map(self.clipCellReactorFactory)
      .map(ClipListViewSectionItem.clip)
  }
}
