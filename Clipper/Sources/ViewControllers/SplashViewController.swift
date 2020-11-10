//
//  SplashViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

import Lottie
import ReactorKit
import RxViewController
import SnapKit

class SplashViewController: BaseViewController, View {
  typealias Reactor = SplashViewReactor

  private let presentLoginScreen: () -> Void
  private let presentMainScreen: () -> Void

  fileprivate let animationView: AnimationView = {
    let view = AnimationView(name: "Splash")
    view.loopMode = .loop
    return view
  }()

  fileprivate let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Clipper"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30, weight: .bold)
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.animationView.play()
  }

  override func addSubViews() {
    self.view.addSubview(animationView)
    self.view.addSubview(nameLabel)
  }

  override func setupConstraints() {
    self.animationView.snp.makeConstraints { make in
      make.width.height.equalTo(view.frame.height / 5)
      make.centerX.centerY.equalToSuperview()
    }

    self.nameLabel.snp.makeConstraints { make in
      make.centerX.equalTo(animationView)
      make.top.equalTo(animationView.snp.bottom).offset(15)
      make.leading.equalToSuperview().offset(15)
      make.trailing.equalToSuperview().offset(-15)
    }
  }

  // MARK: Initialize

  init(
    reactor: Reactor,
    presentLoginScreen: @escaping () -> Void,
    presentMainScreen: @escaping () -> Void
  ) {
    defer { self.reactor = reactor }
    self.presentLoginScreen = presentLoginScreen
    self.presentMainScreen = presentMainScreen
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func bind(reactor: SplashViewReactor) {
    self.rx.viewDidAppear
      .map { _ in Reactor.Action.checkAuthenticated }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)

    reactor.state.compactMap { $0.isAuthenticated }
      .distinctUntilChanged()
      .subscribe(
        onNext: { [weak self] isAuthenticated in
          if isAuthenticated {
            self?.presentMainScreen()
          } else {
            self?.presentLoginScreen()
          }
        })
      .disposed(by: disposeBag)
  }
}
