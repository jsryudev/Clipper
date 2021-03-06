//
//  ClipListViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/28.
//

import UIKit

import ReactorKit
import ReusableKit
import RxDataSources

class ClipListViewController: BaseViewController, View {
  typealias Reactor = ClipListViewReactor
  
  private let clipDetailViewControllerFactory: (Clip) -> ClipDetailViewController
  
  struct Reusable {
    static let clipCell = ReusableCell<ClipCell>()
  }
  
  let dataSource: RxTableViewSectionedReloadDataSource<ClipListViewSection>
  
  fileprivate let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
  
  let tableView: UITableView = {
    let view = UITableView(frame: .zero, style: .plain)
    view.register(Reusable.clipCell)
    return view
  }()
  
  init(
    reactor: Reactor,
    clipDetailViewControllerFactory: @escaping (Clip) -> ClipDetailViewController
  ) {
    defer { self.reactor = reactor }
    self.clipDetailViewControllerFactory = clipDetailViewControllerFactory
    self.dataSource = type(of: self).dataSourceFactory()
    super.init()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<ClipListViewSection> {
    return .init(configureCell: { dataSource, tableView, indexPath, sectionItem in
      switch sectionItem {
      case .clip(let reactor):
        let cell = tableView.dequeue(Reusable.clipCell, for: indexPath)
        cell.reactor = reactor
        return cell
      }
    })
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func addSubViews() {
    self.title = "Clip 목록"
    self.navigationItem.rightBarButtonItem = self.closeButton
    
    self.view.addSubview(tableView)
  }
  
  override func setupConstraints() {
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func bind(reactor: ClipListViewReactor) {
    self.closeButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
    
    self.rx.viewDidLoad
      .map { Reactor.Action.refresh }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    self.tableView.rx.itemSelected(dataSource: self.dataSource)
      .subscribe(onNext: { [weak self] sectionItem in
        switch sectionItem {
        case .clip(let clipReactor):
          guard let vc = self?.clipDetailViewControllerFactory(clipReactor.currentState) else { return }
          self?.navigationController?.pushViewController(vc, animated: true)
        }
      })
      .disposed(by: disposeBag)
    
    self.tableView.rx.itemSelected
      .subscribe(onNext: { [weak tableView] indexPath in
        tableView?.deselectRow(at: indexPath, animated: true)
      })
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.sections }
      .bind(to: self.tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
