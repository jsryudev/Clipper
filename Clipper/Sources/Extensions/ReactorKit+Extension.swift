//
//  ReactorKit+Extension.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import RxCocoa
import RxSwift
import ReactorKit

extension ObservableType {
  func mapChangedTrackedValue<T> (_ transform: @escaping (Element) throws -> TrackedValue<T>) -> Observable<T> {
    return self
      .map(transform)
      .distinctUntilChanged { $0.tracker == $1.tracker }
      .map { $0.value }
  }
}
