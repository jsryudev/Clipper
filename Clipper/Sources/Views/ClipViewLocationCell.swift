//
//  ClipViewLocationCell.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import SnapKit
import ReactorKit

final class ClipViewLocationCell: BaseTableViewCell, View {
  typealias Reactor = ClipViewLocationCellReactor

  fileprivate let locationLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(locationLabel)
    self.backgroundColor = .clear
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.locationLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  func bind(reactor: ClipViewLocationCellReactor) {
    locationLabel.text = reactor.currentState
  }
}

