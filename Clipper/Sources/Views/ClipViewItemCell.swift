//
//  ClipViewItemCell.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import SnapKit
import ReactorKit

final class ClipViewItemCell: BaseTableViewCell, View {
  typealias Reactor = ClipViewItemCellReactor

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }

  func bind(reactor: ClipViewItemCellReactor) {
    print(reactor)
    self.textLabel?.text = reactor.currentState.title
    self.detailTextLabel?.text  = reactor.currentState.content
  }
}


