//
//  AccountViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/29.
//

import UIKit

import GoogleSignIn
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import RxViewController

class AccountViewController: BaseViewController, View {
  typealias Reactor = AccountViewReactor

  private let presentMainScreen: () -> Void

  fileprivate let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Clipper"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30, weight: .bold)
    label.textColor = .black
    return label
  }()

  fileprivate let googleAccountButton: GIDSignInButton = {
    let button = GIDSignInButton()
    button.style = .wide
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func addSubViews() {
    self.view.addSubview(nameLabel)
    self.view.addSubview(googleAccountButton)
  }

  override func setupConstraints() {
    self.nameLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-50)
      make.leading.equalToSuperview().offset(15)
      make.trailing.equalToSuperview().offset(-15)
    }

    googleAccountButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(nameLabel.snp.bottom).offset(30)
    }
  }

  // MARK: Initialize

  init(
    reactor: Reactor,
    presentMainScreen: @escaping () -> Void
  ) {
    defer { self.reactor = reactor }
    self.presentMainScreen = presentMainScreen
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func bind(reactor: AccountViewReactor) {
    self.rx.viewDidLoad
      .subscribe(
        onNext: { [weak self] in
          self?.initalizeGoogleSignIn()
        })
      .disposed(by: disposeBag)

    reactor.state.compactMap { $0.isSignIn }
      .distinctUntilChanged()
      .subscribe(
        onNext: { [weak self] isSignIn in
          if isSignIn {
            self?.presentMainScreen()
          } else {
            // 가입 화면 이동
          }
        })
      .disposed(by: disposeBag)

  }
}

extension AccountViewController: GIDSignInDelegate {
    func initalizeGoogleSignIn() {
      GIDSignIn.sharedInstance().delegate = self
      GIDSignIn.sharedInstance().presentingViewController = self
      GIDSignIn.sharedInstance().restorePreviousSignIn()
    }

  func sign(_ signIn: GIDSignIn?, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
    guard let authentication = user?.authentication else {
      return
    }
    reactor?.action.onNext(.signIn(authentication.idToken))
  }
}
