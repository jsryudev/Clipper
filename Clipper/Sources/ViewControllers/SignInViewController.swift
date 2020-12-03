//
//  SignInViewController.swift
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

class SignInViewController: BaseViewController, View {
  typealias Reactor = SignInViewReactor

  private let presentMainScreen: () -> Void
  private let signUpViewControllerFactory: (String) -> SignUpViewController

  fileprivate let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Clipper"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30, weight: .bold)
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
    presentMainScreen: @escaping () -> Void,
    signUpViewControllerFactory: @escaping (String) -> SignUpViewController
  ) {
    defer { self.reactor = reactor }
    self.presentMainScreen = presentMainScreen
    self.signUpViewControllerFactory = signUpViewControllerFactory
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func bind(reactor: SignInViewReactor) {
    self.rx.viewDidLoad
      .subscribe(onNext: { [weak self] in
        self?.initalizeGoogleSignIn()
      })
      .disposed(by: disposeBag)

    reactor.state.compactMap { $0.isSuccess }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] isSuccess in
        if isSuccess.value {
          self?.presentMainScreen()
        } else {
          guard let idToken = reactor.currentState.idToken,
                let viewController = self?.signUpViewControllerFactory(idToken)
          else {
            // handle error
            return
          }
          self?.navigationController?.pushViewController(viewController, animated: true)
        }
      })
      .disposed(by: disposeBag)
  }
}

extension SignInViewController: GIDSignInDelegate {
  func initalizeGoogleSignIn() {
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().presentingViewController = self
  }

  func sign(_ signIn: GIDSignIn?, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
    guard let authentication = user?.authentication else {
      return
    }
    reactor?.action.onNext(.authenticate(authentication.idToken))
  }
}
