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
  fileprivate let currentLocationButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "location.fill"), for: .normal)
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(self.currentLocationButton)
    self.setConstraints()
    self.setLayer()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setConstraints() {
    self.currentLocationButton.snp.makeConstraints { make in
      make.height.width.equalTo(self.snp.width)
      make.edges.equalToSuperview()
    }
  }

  func setLayer() {
    self.layer.cornerRadius = 4
  }
}

extension Reactive where Base: MapAccessoriesView {
  var currentLocationButtonTap: ControlEvent<Void> {
    let source = base.currentLocationButton.rx.tap
    return ControlEvent(events: source)
  }
}
