//
//  ClipViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import ReactorKit

final class ClipViewReactor: Reactor {

  enum Action {
    case configure
    case refresh
    case loadMore
  }

  enum Mutation {
    case appendSections(ClipViewSection)
    case appendClips([ClipItem])
  }

  struct State {
    let marker: Marker
    var sections: [ClipViewSection] = []
    var page = 1

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
      print(currentState.marker.id)
      return .empty()

    case .refresh:
      guard let marker = currentState.marker.id else {
        return .empty()
      }

      return clipService.fetchClips(marker: marker, page: 1, limit: 5)
        .asObservable()
        .map { clip -> Mutation in
          return .appendClips(clip.items)
        }

    case .loadMore:
      guard let marker = currentState.marker.id else {
        return .empty()
      }

      let appendClips = self.clipService
        .fetchClips(marker: marker, page: currentState.page, limit: 5)
        .asObservable()
        .map { clip -> Mutation in

          return .appendClips(clip.items)
        }

      return appendClips
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .appendSections(let section):
      newState.sections.append(section)
    case .appendClips(let clips):
      let sectionItems = self.clipViewSectionItems(with: clips)
      
      newState.sections = [
        state.sections[0],
        state.sections[1] ,
        .clipList("CLIP 목록", sectionItems)
      ]
    }
    return newState
  }

  private func clipViewSectionItems(with clips: [ClipItem]) -> [ClipViewSectionItem] {
    return clips
      .map(self.clipViewItemCellReactorFactory)
      .map(ClipViewSectionItem.clip)
  }
}
