//
//  WelcomeViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift
import RxViewController
import SnapKit

class WelcomeViewController: BaseViewController, View {
  typealias Reactor = WelcomeViewReactor

  fileprivate let welcomeLabel: UILabel = {
    let label = UILabel()
    label.text = "반갑습니다!"
    label.font = .systemFont(ofSize: 30, weight: .bold)
    return label
  }()

  fileprivate let userNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20)
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .clear
  }

  override func addSubViews() {
    self.view.addSubview(welcomeLabel)
    self.view.addSubview(userNameLabel)
  }

  override func setupConstraints() {
    welcomeLabel.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(15)
    }

    userNameLabel.snp.makeConstraints { make in
      make.bottom.equalTo(welcomeLabel.snp.bottom)
      make.leading.equalTo(welcomeLabel.snp.trailing).offset(15)
    }
  }

  // MARK: Initialize

  init(reactor: Reactor) {
    defer { self.reactor = reactor }
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func bind(reactor: WelcomeViewReactor) {
    self.userNameLabel.text = "\(reactor.currentState.name) 님"
  }
}
