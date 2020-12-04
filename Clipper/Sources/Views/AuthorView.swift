//
//  AuthorView.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/12/04.
//

import UIKit

class AuthorView: UIView {
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 24)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(self.nameLabel)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setConstraints() {
  }
}
