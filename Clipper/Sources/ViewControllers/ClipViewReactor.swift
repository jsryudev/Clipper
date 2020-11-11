//
//  ClipViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import ReactorKit

final class ClipViewReactor: Reactor {

  enum Action {
    case refresh
    case loadMore
  }

  enum Mutation {
    case appendSections(ClipViewSection)
    case appendClips([ClipItem])
  }

  struct State {
    let markerId: String?
    let coordinate: Coordinate
    var sections: [ClipViewSection] = []
    var page = 1

    init(marker id: String?, coordinate: Coordinate, sections: [ClipViewSection]) {
      self.markerId = id
      self.coordinate = coordinate
      self.sections = sections
    }
  }

  let initialState: State
  let clipService: ClipServiceType
  let clipViewItemCellReactorFactory: (ClipItem) -> ClipViewItemCellReactor

  init(
    marker id: String? = nil,
    coordinate: Coordinate,
    clipService: ClipServiceType,
    clipViewItemCellReactorFactory: @escaping (ClipItem) -> ClipViewItemCellReactor
  ) {
    let actionSection = ClipViewSection.action("기능", [.action])
    let locationSection = ClipViewSection.location("위치", [.location(ClipViewLocationCellReactor(title: "현재 위치"))])
    self.clipService = clipService
    self.clipViewItemCellReactorFactory = clipViewItemCellReactorFactory
    self.initialState = State(marker: id, coordinate: coordinate, sections: [actionSection, locationSection])
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .refresh:
      guard let marker = currentState.markerId else {
        print("nil!")
        return .empty()
      }

      return clipService.fetchClips(marker: marker, page: 1, limit: 5)
        .asObservable()
        .map { clip -> Mutation in
          print(clip)
          return .appendClips(clip.items)
        }

    case .loadMore:
      guard let marker = currentState.markerId else {
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
      let sectionItems =  self.clipViewSectionItems(with: clips)
      
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
