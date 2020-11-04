//
//  AuthorizationView.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/05.
//

import UIKit

import RxSwift
import RxCocoa

class AuthorizationView: UIView {
  fileprivate let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Clipper"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30, weight: .bold)
    label.textColor = .black
    return label
  }()

  fileprivate let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Clipper는 사용자의 위치를 기반으로 서비스를 제공합니다. 위치 권한이 필요합니다."
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()

  fileprivate let requestButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.black, for: .normal)
    button.setTitle("권한 부여", for: .normal)
    return button
  }()

  fileprivate let settingsButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.black, for: .normal)
    button.setTitle("설정으로 가기", for: .normal)
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension Reactive where Base: AuthorizationView {
}
