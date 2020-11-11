//
//  ClipViewLoactionCellReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import ReactorKit

final class ClipViewLocationCellReactor: Reactor {
  typealias Action = NoAction

  let initialState: String

  init(title: String) {
    self.initialState = title
  }
}
