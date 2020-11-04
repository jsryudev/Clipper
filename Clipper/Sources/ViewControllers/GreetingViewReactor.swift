//
//  GreetingViewReactor.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import ReactorKit

final class GreetingViewReactor: Reactor {
  typealias Action = NoAction

  let initialState: User

  init(user: User) {
    self.initialState = user
  }
}
