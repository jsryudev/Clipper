//
//  MapAccessoriesView.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/04.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

class MapAccessoriesView: UIView {
  fileprivate let addButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.black, for: .normal)
    button.setTitle("추가", for: .normal)
    return button
  }()

  fileprivate let currentLocationButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.black, for: .normal)
    button.setTitle("위치", for: .normal)
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(self.addButton)
    self.addSubview(self.currentLocationButton)
    self.setConstraints()
    self.setLayer()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setConstraints() {
    self.addButton.snp.makeConstraints { make in
      make.height.width.equalTo(self.snp.width)
      make.top.leading.trailing.equalToSuperview()
    }

    self.currentLocationButton.snp.makeConstraints { make in
      make.height.width.equalTo(self.snp.width)
      make.top.equalTo(self.addButton.snp.bottom)
      make.leading.trailing.equalToSuperview()
    }
  }

  func setLayer() {
    self.layer.cornerRadius = 8
  }
}

extension Reactive where Base: MapAccessoriesView {
  var addButtonTap: ControlEvent<Void> {
    let source = base.addButton.rx.tap
    return ControlEvent(events: source)
  }

  var currentLocationButtonTap: ControlEvent<Void> {
    let source = base.currentLocationButton.rx.tap
    return ControlEvent(events: source)
  }
}
