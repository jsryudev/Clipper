//
//  MarkerViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import ReactorKit
import ReusableKit
import RxDataSources

class MarkerViewController: BaseViewController, View {
  typealias Reactor = MarkerViewReactor

  fileprivate struct Reusable {
    static let addActionCell = ReusableCell<MarkerViewAddCell>()
    static let locationCell = ReusableCell<MarkerViewLocationCell>()
    static let itemCell = ReusableCell<MarkerViewItemCell>()
    static let moreActionCell = ReusableCell<MarkerViewMoreCell>()
  }

  fileprivate let dataSource: RxTableViewSectionedReloadDataSource<MarkerViewSection>

  let tableView: UITableView = {
    let view = UITableView(frame: .zero, style: .grouped)
    view.backgroundColor = .clear
    view.separatorStyle = .none
    view.register(Reusable.addActionCell)
    view.register(Reusable.locationCell)
    view.register(Reusable.itemCell)
    view.register(Reusable.moreActionCell)
    return view
  }()

  // MARK: Initialize

  init(
    reactor: Reactor,
    markerViewAddCellDependency: MarkerViewAddCell.Dependency
  ) {
    defer { self.reactor = reactor }
    self.dataSource = type(of: self).dataSourceFactory(markerViewAddCellDependency: markerViewAddCellDependency)
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private static func dataSourceFactory(
    markerViewAddCellDependency: MarkerViewAddCell.Dependency
  ) -> RxTableViewSectionedReloadDataSource<MarkerViewSection> {
    return .init(
      configureCell: { dataSource, tableView, indexPath, sectionItem in
        let cell: UITableViewCell
        switch sectionItem {
        case .action:
          let actionCell = tableView.dequeue(Reusable.addActionCell, for: indexPath)
          actionCell.dependency = markerViewAddCellDependency
          cell = actionCell
        case .location(let reactor):
          let locationCell = tableView.dequeue(Reusable.locationCell, for: indexPath)
          locationCell.reactor = reactor
          cell = locationCell
        case .clip(let reactor):
          let itemCell = tableView.dequeue(Reusable.itemCell, for: indexPath)
          itemCell.reactor = reactor
          cell = itemCell
        case .more:
          let actionCell = tableView.dequeue(Reusable.moreActionCell, for: indexPath)
          cell = actionCell
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

  func bind(reactor: MarkerViewReactor) {
    self.rx.viewDidLoad
      .map { Reactor.Action.configure }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    reactor.state.map { $0.sections }
      .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
  }
}
