//
//  ReactorKit+Extension.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import RxCocoa
import RxSwift
import ReactorKit

struct TrackedValue<T: Equatable>: Equatable {
  var tracker: Int
  var value: T

  static func == (lhs: TrackedValue<T>, rhs: TrackedValue<T>) -> Bool {
    return lhs.tracker == rhs.tracker && lhs.value == rhs.value
  }
}

extension ObservableType {
  func mapChangedTrackedValue<T> (_ transform: @escaping (Element) throws -> TrackedValue<T>) -> Observable<T> {
    return self
      .map(transform)
      .distinctUntilChanged { $0.tracker == $1.tracker }
      .map { $0.value }
  }
}
