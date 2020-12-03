//
//  ClipDetailViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/29.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

class ClipDetailViewController: BaseViewController, View {
  typealias Reactor = ClipDetailViewReactor
  
  fileprivate let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
  
  fileprivate let stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    return view
  }()
  
  fileprivate let contentLabel: UILabel = {
    let label = UILabel()
    label.text = "내용"
    return label
  }()
  
  fileprivate let contentTextView: UITextView = {
    let view = UITextView()
    view.font = .systemFont(ofSize: 17)
    view.isEditable = false
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func addSubViews() {
    self.navigationItem.rightBarButtonItem = self.cancelButton
    
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
  
  func bind(reactor: ClipDetailViewReactor) {
    self.cancelButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.dismiss(animated: true)
      }).disposed(by: disposeBag)
    
    self.title = reactor.currentState.title
    self.contentTextView.text = reactor.currentState.content
  }
}
