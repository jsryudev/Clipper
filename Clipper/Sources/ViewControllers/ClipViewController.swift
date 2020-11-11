//
//  ClipViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import ReactorKit

class ClipViewController: BaseViewController, View {
  typealias Reactor = ClipViewReactor

  fileprivate let tableView: UITableView = {
    let view = UITableView()
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func addSubViews() {
  }

  override func setupConstraints() {
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
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

  func bind(reactor: ClipViewReactor) {
  }
}
