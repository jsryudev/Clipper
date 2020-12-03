//
//  ClipCell.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/28.
//

import UIKit

import ReactorKit

final class ClipCell: BaseTableViewCell, View {
  typealias Reactor = ClipCellReactor
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .clear
  }
  
  func bind(reactor: ClipCellReactor) {
    self.textLabel?.text = reactor.currentState.title
    self.detailTextLabel?.text  = reactor.currentState.content
  }
}
