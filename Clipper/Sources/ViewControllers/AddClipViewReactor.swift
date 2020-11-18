//
//  AddClipViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/10.
//

import ReactorKit

final class AddClipViewReactor: Reactor {

  enum Action {
    case create
  }

  enum Mutation {
  }

  struct State {
    let marker: Marker
  }

  let initialState: State

  init(marker: Marker) {
    self.initialState = State(marker: marker)
  }
}
