//
//  BaseViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }

  var disposeBag = DisposeBag()

  private(set) var didSetupConstraints = false

  override func viewDidLoad() {
    self.view.setNeedsUpdateConstraints()
    self.addSubViews()

    self.view.backgroundColor = .systemBackground
  }

  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }

  func addSubViews() {
    // Override point
  }

  func setupConstraints() {
    // Override point
  }
}
