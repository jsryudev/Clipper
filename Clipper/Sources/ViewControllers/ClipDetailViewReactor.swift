//
//  ClipDetailViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/29.
//

import ReactorKit

class ClipDetailViewReactor: Reactor {
  typealias Action = NoAction
  
  let initialState: Clip
  
  init(clip: Clip) {
    self.initialState = clip
  }
}
