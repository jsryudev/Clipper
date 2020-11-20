//
//  UITableView+Rx.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/21.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

extension Reactive where Base: UITableView {
  func itemSelected<S>(dataSource: TableViewSectionedDataSource<S>) -> ControlEvent<S.Item> {
    let source = self.itemSelected.map { indexPath in
      dataSource[indexPath]
    }
    return ControlEvent(events: source)
  }
}
