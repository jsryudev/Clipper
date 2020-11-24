//
//  TrackedValue.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/25.
//

import Foundation

struct TrackedValue<T: Equatable>: Equatable {
  var tracker: Int
  var value: T

  static func == (lhs: TrackedValue<T>, rhs: TrackedValue<T>) -> Bool {
    return lhs.tracker == rhs.tracker && lhs.value == rhs.value
  }
}
