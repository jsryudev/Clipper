//
//  MarkerViewLocationCell.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import SnapKit
import ReactorKit

final class MarkerViewLocationCell: BaseTableViewCell, View {
  typealias Reactor = MarkerViewLocationCellReactor
  
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
  
  func bind(reactor: MarkerViewLocationCellReactor) {
    locationLabel.text = reactor.currentState
  }
}

