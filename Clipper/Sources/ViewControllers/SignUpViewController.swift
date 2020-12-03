//
//  SignUpViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import UIKit

import Hero
import GoogleSignIn
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import RxViewController

class SignUpViewController: BaseViewController, View {
  typealias Reactor = SignUpViewReactor
  
  private let presentMainScreen: () -> Void
  
  fileprivate let doneButton: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = "확인"
    return button
  }()
  
  fileprivate let nameTextField: UITextField = {
    let field = UITextField()
    field.borderStyle = .line
    field.textAlignment = .center
    field.font = .systemFont(ofSize: 18)
    field.placeholder = "사용할 닉네임"
    return field
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
  }
  
  override func addSubViews() {
    self.navigationItem.rightBarButtonItem = doneButton
    self.view.addSubview(nameTextField)
    self.view.addSubview(nameLabel)
  }
  
  override func setupConstraints() {
    self.nameTextField.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.leading.equalToSuperview().offset(30)
      make.trailing.equalToSuperview().offset(-30)
    }
    
    self.nameLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(nameTextField.snp.top).offset(-30)
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
  
  func bind(reactor: SignUpViewReactor) {
    self.nameTextField.rx.text
      .distinctUntilChanged()
      .compactMap{ $0 }
      .map { Reactor.Action.typeName($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    self.doneButton.rx.tap
      .map { Reactor.Action.signUp }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.compactMap { $0.isSuccess }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] isSuccess in
        if isSuccess.value {
          self?.presentMainScreen()
        } else {
          // handle error
        }
      })
      .disposed(by: disposeBag)
  }
}
