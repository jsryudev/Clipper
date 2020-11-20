//
//  MarkerViewItemCell.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import SnapKit
import ReactorKit

final class MarkerViewItemCell: BaseTableViewCell, View {
  typealias Reactor = MarkerViewItemCellReactor

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .clear
  }

  func bind(reactor: MarkerViewItemCellReactor) {
    self.textLabel?.text = reactor.currentState.title
    self.detailTextLabel?.text  = reactor.currentState.content
  }
}


