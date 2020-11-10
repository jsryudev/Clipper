//
//  AddClipViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/10.
//

import Foundation

import UIKit
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import RxViewController

class AddClipViewController: BaseViewController, View {
  typealias Reactor = AddClipViewReactor

  fileprivate let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "제목"
    return label
  }()

  fileprivate let titleTextField: UITextField = {
    let field = UITextField()
    field.placeholder = "제목을 입력해주세요."
    return field
  }()

  fileprivate let contentLabel: UILabel = {
    let label = UILabel()
    label.text = "내용"
    return label
  }()

  fileprivate let contentTextView: UITextView = {
    let view = UITextView()
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func addSubViews() {
  }

  override func setupConstraints() {
  }

  // MARK: Initialize

  init(reactor: Reactor) {
    defer { self.reactor = reactor }
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func bind(reactor: AddClipViewReactor) {

  }
}
