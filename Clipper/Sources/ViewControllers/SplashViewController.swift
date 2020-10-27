//
//  SplashViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

import ReactorKit

class SplashViewController: BaseViewController, View {
  typealias Reactor = SplashViewReactor

  private let presentLoginScreen: () -> Void
  private let presentMainScreen: () -> Void

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: Initializing

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
  }
}
