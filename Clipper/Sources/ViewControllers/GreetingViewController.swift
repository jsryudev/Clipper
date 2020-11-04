//
//  GreetingViewController.swift
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


class GreetingViewController: BaseViewController, View {
  typealias Reactor = GreetingViewReactor

  fileprivate let greetingLabel: UILabel = {
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


  let containerView: UIView = {
    let view = UIView()
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .clear
  }

  override func addSubViews() {
    self.view.addSubview(greetingLabel)
    self.view.addSubview(userNameLabel)
    self.view.addSubview(containerView)
  }

  override func setupConstraints() {
    greetingLabel.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(15)
    }

    userNameLabel.snp.makeConstraints { make in
      make.bottom.equalTo(greetingLabel.snp.bottom)
      make.leading.equalTo(greetingLabel.snp.trailing).offset(15)
    }

    containerView.snp.makeConstraints { make in
      make.top.equalTo(greetingLabel.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
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

  func bind(reactor: GreetingViewReactor) {
    self.userNameLabel.text = "\(reactor.currentState.user.name) 님"

    self.rx.viewDidLoad
      .map { _ in Reactor.Action.checkCurrentAuthorization }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    reactor.state.compactMap { $0.currentAuthorization }
      .subscribe(
        onNext: { currentAuthorization in

        })
      .disposed(by: disposeBag)

    reactor.state.compactMap { $0.changedAuthorization }
      .subscribe(
        onNext: { changedAuthorization in

        })
      .disposed(by: disposeBag)
  }
}
