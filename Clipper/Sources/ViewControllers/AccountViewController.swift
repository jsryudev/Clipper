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

  func bind(reactor: AccountViewReactor) {
    self.rx.viewDidLoad
      .subscribe(
        onNext: { [weak self] in
          self?.initalizeGoogleSignIn()
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
    guard let user = user else { return }
    // idToken을 백엔드로 보내 인증을 진행
  }
}
