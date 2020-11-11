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
    var sections: [ClipViewSection] = []

    init(sections: [ClipViewSection]) {
      self.sections = sections
    }
  }

  let initialState: State

  init() {
    let actionSection = ClipViewSection.action("기능", [.action])
    let locationSection = ClipViewSection.location("위치", [.location(ClipViewLocationCellReactor(title: "현재 위치"))])
    self.initialState = State(sections: [actionSection, locationSection])
  }
}
