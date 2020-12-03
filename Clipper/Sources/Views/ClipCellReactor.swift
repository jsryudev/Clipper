//
//  ClipCellReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/28.
//

import ReactorKit

final class ClipCellReactor: Reactor {
  typealias Action = NoAction
  
  let initialState: Clip
  
  init(clip: Clip) {
    self.initialState = clip
  }
}
