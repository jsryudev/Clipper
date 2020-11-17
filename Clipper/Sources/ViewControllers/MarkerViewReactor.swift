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
  let markerViewLocaionCellReactorFactory: (String) -> MarkerViewLocationCellReactor
  let markerViewItemCellReactorFactory: (Clip) -> MarkerViewItemCellReactor

  init(
    marker: Marker,
    clipService: ClipServiceType,
    markerViewLocaionCellReactorFactory: @escaping (String) -> MarkerViewLocationCellReactor,
    markerViewItemCellReactorFactory: @escaping (Clip) -> MarkerViewItemCellReactor
  ) {
    self.clipService = clipService
    self.markerViewLocaionCellReactorFactory = markerViewLocaionCellReactorFactory
    self.markerViewItemCellReactorFactory = markerViewItemCellReactorFactory
    let defalutSection = MarkerViewSection.action("기능", [.action])
    self.initialState = State(marker: marker, sections: [defalutSection])
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .configure:
      let marker = self.currentState.marker

      let locationItems = self.markerViewLocationSectionItems(with: "\(marker.location.latitude), \(marker.location.longitude)")
      var sections: [MarkerViewSection] = [.location("위치", locationItems)]

      if let clips = currentState.marker.clips, !clips.isEmpty {
        let clipItems = self.markerViewClipsSectionItems(with: clips)
        sections.append(MarkerViewSection.clips("클립 (5건)", clipItems))
      }

      return .just(.configureSections(sections))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .configureSections(let sections):
      newState.sections.append(contentsOf: sections)
    }
    return newState
  }

  private func markerViewLocationSectionItems(with location: String) -> [MarkerViewSectionItem] {
    return [.location(self.markerViewLocaionCellReactorFactory(location))]
  }

  private func markerViewClipsSectionItems(with clips: [Clip]) -> [MarkerViewSectionItem] {
    var items = clips
      .map(self.markerViewItemCellReactorFactory)
      .map(MarkerViewSectionItem.clip)
    items.append(.more)
    return items
  }
}
