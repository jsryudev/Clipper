//
//  ClipViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import ReactorKit

final class ClipViewReactor: Reactor {

  enum Action {
  }

  enum Mutation {
  }

  struct State {
    let coordinate: Coordinate
    var sections: [ClipViewSection] = []

    init(coordinate: Coordinate, sections: [ClipViewSection]) {
      self.coordinate = coordinate
      self.sections = sections
    }
  }

  let initialState: State

  init(coordinate: Coordinate) {
    let actionSection = ClipViewSection.action("기능", [.action])
    let locationSection = ClipViewSection.location("위치", [.location(ClipViewLocationCellReactor(title: "현재 위치"))])
    self.initialState = State(coordinate: coordinate, sections: [actionSection, locationSection])
  }
}
