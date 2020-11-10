//
//  LocationAuthorizationView.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/05.
//

import UIKit

import RxSwift
import RxCocoa

class LocationAuthorizationView: UIView {
  fileprivate var type: AuthorizationType = .notDetermined

  struct Text {
    static let title = "Clipper"
    static let authorized = "이제 Clipper를 이용할 수 있습니다."
    static let denied = "위치 권한이 거부되었습니다.\n설정에서 권한을 허용해주세요."
    static let notDetermined = "Clipper는 위치를 기반으로 서비스를 제공합니다.\n권한을 허용해주세요."
    static let deniedAction = "설정으로 이동"
    static let notDeterminedAction = "권한 부여"
  }

  fileprivate let titleLabel: UILabel = {
    let label = UILabel()
    label.text = Text.title
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30, weight: .bold)
    return label
  }()

  fileprivate let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = Text.notDetermined
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  fileprivate let actionButton: UIButton = {
    let button = UIButton()
    button.setTitle(Text.notDeterminedAction, for: .normal)
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(self.titleLabel)
    self.addSubview(self.descriptionLabel)
    self.addSubview(self.actionButton)
    self.setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(50)
      make.centerX.equalToSuperview()
    }

    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }

    actionButton.snp.makeConstraints { make in
      make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }
  }

  func set(authorization: AuthorizationType) {
    self.type = authorization
    switch authorization {
    case .authorized:
      self.descriptionLabel.text = Text.authorized
    case .denied:
      self.descriptionLabel.text = Text.denied
      self.actionButton.setTitle(Text.deniedAction, for: .normal)
    case .notDetermined:
      self.descriptionLabel.text = Text.notDetermined
      self.actionButton.setTitle(Text.notDeterminedAction, for: .normal)
    }
    self.actionButton.isHidden = authorization == .authorized
  }
}

extension Reactive where Base: LocationAuthorizationView {
  var actionButtonTap: ControlEvent<AuthorizationType> {
    let source = base.actionButton.rx.tap.compactMap { base.type }
    return ControlEvent(events: source)
  }
}
