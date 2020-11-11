//
//  ClipViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import ReactorKit
import ReusableKit
import RxDataSources

class ClipViewController: BaseViewController, View {
  typealias Reactor = ClipViewReactor

  fileprivate struct Reusable {
    static let actionCell = ReusableCell<ClipViewActionCell>()
    static let locationCell = ReusableCell<ClipViewLocationCell>()
    static let itemCell = ReusableCell<ClipViewItemCell>()
  }

  fileprivate let dataSource: RxTableViewSectionedReloadDataSource<ClipViewSection>

  let tableView: UITableView = {
    let view = UITableView(frame: .zero, style: .grouped)
    view.backgroundColor = .clear
    view.register(Reusable.actionCell)
    view.register(Reusable.locationCell)
    view.register(Reusable.itemCell)
    return view
  }()

  // MARK: Initialize

  init(reactor: Reactor) {
    defer { self.reactor = reactor }
    self.dataSource = type(of: self).dataSourceFactory()
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<ClipViewSection> {
    return .init(
      configureCell: { dataSource, tableView, indexPath, sectionItem in
        let cell: UITableViewCell
        switch sectionItem {
        case .action:
          let actionCell = tableView.dequeue(Reusable.actionCell, for: indexPath)
          cell = actionCell
        case .location(let reactor):
          let locationCell = tableView.dequeue(Reusable.locationCell, for: indexPath)
          locationCell.reactor = reactor
          cell = locationCell
        case .clip(let reactor):
          let itemCell = tableView.dequeue(Reusable.itemCell, for: indexPath)
          itemCell.reactor = reactor
          cell = itemCell
        }
        return cell
      },
      titleForHeaderInSection: { dataSource, index  in
        return dataSource.sectionModels[index].title
      }
    )
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .clear
  }

  override func addSubViews() {
    self.view.addSubview(tableView)
  }

  override func setupConstraints() {
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  func bind(reactor: ClipViewReactor) {
    self.rx.viewDidLoad
      .map { Reactor.Action.refresh }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    reactor.state.map { $0.sections }
      .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
  }
}
