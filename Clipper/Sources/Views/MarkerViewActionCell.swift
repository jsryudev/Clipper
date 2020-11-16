//
//  MarkerViewActionCell.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import SnapKit

final class MarkerViewActionCell: BaseTableViewCell {

  fileprivate let actionButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.setTitle("추가", for: .normal)
    return button
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(actionButton)
    self.backgroundColor = .clear
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.actionButton.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
