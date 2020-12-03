//
//  NewClipViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/10.
//

import UIKit

import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import RxViewController

class NewClipViewController: BaseViewController, View {
  typealias Reactor = NewClipViewReactor
  
  fileprivate let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
  fileprivate let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
  
  fileprivate let stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    return view
  }()
  
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
  
  fileprivate let contentTextView = UITextView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func addSubViews() {
    self.navigationItem.leftBarButtonItem = self.cancelButton
    self.navigationItem.rightBarButtonItem = self.doneButton
    
    self.stackView.addArrangedSubview(self.titleLabel)
    self.stackView.addArrangedSubview(self.titleTextField)
    self.stackView.addArrangedSubview(self.contentLabel)
    self.stackView.addArrangedSubview(self.contentTextView)
    
    self.view.addSubview(self.stackView)
  }
  
  override func setupConstraints() {
    self.stackView.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      make.left.right.equalToSuperview().inset(15)
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
  
  func bind(reactor: NewClipViewReactor) {
    self.cancelButton.rx.tap
      .map { Reactor.Action.dismiss }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    self.doneButton.rx.tap
      .map { Reactor.Action.done }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    self.titleTextField.rx.text
      .distinctUntilChanged()
      .compactMap { $0 }
      .map { Reactor.Action.title($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    self.contentTextView.rx.text
      .distinctUntilChanged()
      .compactMap { $0 }
      .map { Reactor.Action.content($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.isDismissed }
      .filter { $0 == true }
      .subscribe(onNext: { [weak self] _ in
        self?.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
  }
}
