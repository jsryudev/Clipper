//
//  ClipListViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/28.
//

import UIKit

import ReactorKit

class ClipListViewController: BaseViewController, View {
  typealias Reactor = ClipListViewReactor

  let tableView: UITableView = {
    let view = UITableView(frame: .zero, style: .grouped)
    return view
  }()

  init(reactor: Reactor) {
    defer { self.reactor = reactor }
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func addSubViews() {
    self.view.addSubview(tableView)
  }

  override func setupConstraints() {
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  func bind(reactor: ClipListViewReactor) {
  }
}
