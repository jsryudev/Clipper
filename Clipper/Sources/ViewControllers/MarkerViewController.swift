//
//  MarkerViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import UIKit

import ReactorKit
import ReusableKit
import RxCocoa
import RxDataSources

class MarkerViewController: BaseViewController, View {
  typealias Reactor = MarkerViewReactor

  private let newClipViewControllerFactory: (Marker) -> NewClipViewController

  fileprivate struct Reusable {
    static let actionCell = ReusableCell<MarkerViewActionCell>()
    static let locationCell = ReusableCell<MarkerViewLocationCell>()
    static let itemCell = ReusableCell<MarkerViewItemCell>()
  }

  fileprivate let dataSource: RxTableViewSectionedReloadDataSource<MarkerViewSection>

  let tableView: UITableView = {
    let view = UITableView(frame: .zero, style: .grouped)
    view.backgroundColor = .clear
    view.separatorStyle = .none
    view.register(Reusable.actionCell)
    view.register(Reusable.locationCell)
    view.register(Reusable.itemCell)
    return view
  }()

  // MARK: Initialize

  init(
    reactor: Reactor,
    newClipViewControllerFactory: @escaping (Marker) -> NewClipViewController
  ) {
    defer { self.reactor = reactor }
    self.newClipViewControllerFactory = newClipViewControllerFactory
    self.dataSource = type(of: self).dataSourceFactory()
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<MarkerViewSection> {
    return .init(
      configureCell: { dataSource, tableView, indexPath, sectionItem in
        let cell: UITableViewCell
        switch sectionItem {
        case .add:
          let actionCell = tableView.dequeue(Reusable.actionCell, for: indexPath)
          actionCell.titleLabel.text = "추가하기"
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
          let actionCell = tableView.dequeue(Reusable.actionCell, for: indexPath)
          actionCell.titleLabel.text = "더 보기"
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

    self.tableView.rx.itemSelected(dataSource: self.dataSource)
      .subscribe(
        onNext: { [weak self] sectionItem in
          guard let self = self else { return }
          switch sectionItem {
          case .add:
            let vc = self.newClipViewControllerFactory(reactor.currentState.marker)
            let navigationContoller = UINavigationController(rootViewController: vc)
            self.present(navigationContoller, animated: true)
          case .clip(let clipReactor):
            // Present Clip Detail
            return
          case .more:
            // Present Clip List
            return
          default: return
          }
        })
      .disposed(by: disposeBag)

    self.tableView.rx.itemSelected
      .subscribe(
        onNext: { [weak tableView] indexPath in
          tableView?.deselectRow(at: indexPath, animated: false)
        })
      .disposed(by: self.disposeBag)

    reactor.state.map { $0.sections }
      .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
  }
}
