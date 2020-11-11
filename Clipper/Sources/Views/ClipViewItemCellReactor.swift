//
//  ClipViewItemCellReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import ReactorKit

final class ClipViewItemCellReactor: Reactor {
  typealias Action = NoAction

  let initialState: ClipItem

  init(clip: ClipItem) {
    self.initialState = clip
  }
}
