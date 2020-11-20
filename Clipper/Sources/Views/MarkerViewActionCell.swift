//
//  MarkerViewActionCell.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import SnapKit

final class MarkerViewActionCell: BaseTableViewCell {
  let titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.backgroundColor = .clear
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(titleLabel)
    self.backgroundColor = .clear
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.titleLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
