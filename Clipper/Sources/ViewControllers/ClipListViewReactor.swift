//
//  ClipListViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/28.
//

import Foundation

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
  }

  let initialState: State
  let markerService: MarkerServiceType

  init(
    marker id: String,
    markerService: MarkerServiceType
  ) {
    self.markerService = markerService
    self.initialState = State(markerID: id)
  }
}
