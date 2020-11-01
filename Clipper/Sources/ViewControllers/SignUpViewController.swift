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

  fileprivate let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Clipper"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 30, weight: .bold)
    label.textColor = .black
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func addSubViews() {
    self.view.addSubview(nameLabel)
  }

  override func setupConstraints() {
    self.nameLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.top.equalToSuperview().offset(50)
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
  }
}
