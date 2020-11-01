//
//  MainViewController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import UIKit

import FloatingPanel
import NMapsMap
import ReactorKit
import RxCocoa
import RxSwift
import RxViewController
import SnapKit

class MainViewController: BaseViewController, View {
  typealias Reactor = MainViewReactor

  fileprivate let mapView: NMFMapView = {
    let view = NMFMapView()
    return view
  }()

  fileprivate let floatingPanel: FloatingPanelController = {
    let controller = FloatingPanelController()
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func addSubViews() {
    self.view.addSubview(mapView)
    floatingPanel.addPanel(toParent: self)
  }

  override func setupConstraints() {
    self.mapView.snp.makeConstraints { make in
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

  func bind(reactor: MainViewReactor) {

  }
}
