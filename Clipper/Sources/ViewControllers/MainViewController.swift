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

  private let greetingViewControllerFactory: (User) -> GreetingViewController
  private let markerViewControllerFactory: (Marker) -> MarkerViewController

  fileprivate let mapView: NMFMapView = {
    let view = NMFMapView()
    view.logoAlign = .leftTop
    return view
  }()

  fileprivate let mapAccessoriesView: MapAccessoriesView = {
    let view = MapAccessoriesView()
    view.backgroundColor = UIColor(
      cgColor: CGColor(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 0.95
      )
    )
    return view
  }()

  fileprivate let floatingPanel: FloatingPanelController = {
    let controller = FloatingPanelController()
    let appearance = SurfaceAppearance()
    let shadow = SurfaceAppearance.Shadow()
    shadow.color = UIColor.black
    shadow.offset = CGSize(width: 0, height: 16)
    shadow.radius = 16
    shadow.spread = 8
    appearance.shadows = [shadow]
    appearance.cornerRadius = 16
    appearance.backgroundColor = UIColor(
      cgColor: CGColor(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 0.95
      )
    )
    controller.surfaceView.appearance = appearance
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.floatingPanel.move(to: .tip, animated: false)
    self.initalizeNMapsMap()
  }

  override func addSubViews() {
    self.view.addSubview(mapView)
    self.view.addSubview(mapAccessoriesView)
    floatingPanel.addPanel(toParent: self)
  }

  override func setupConstraints() {
    self.mapView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    self.mapAccessoriesView.snp.makeConstraints { make in
      make.width.height.equalTo(40)
      make.top.equalToSuperview().offset(40)
      make.trailing.equalToSuperview().offset(-15)
    }
  }

  // MARK: Initialize

  init(
    reactor: Reactor,
    greetingViewControllerFactory: @escaping (User) -> GreetingViewController,
    markerViewControllerFactory: @escaping (Marker) -> MarkerViewController
  ) {
    defer { self.reactor = reactor }
    self.greetingViewControllerFactory = greetingViewControllerFactory
    self.markerViewControllerFactory = markerViewControllerFactory
    super.init()
  }

  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func bind(reactor: MainViewReactor) {
    self.rx.viewDidLoad
      .map { Reactor.Action.fetchMe }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    self.mapAccessoriesView.rx
      .currentLocationButtonTap
      .subscribe(
        onNext: { [weak self] in
          self?.setCurrentPosition()
        })
      .disposed(by: disposeBag)

    reactor.state.compactMap { $0.hasAuthorized }
      .distinctUntilChanged()
      .subscribe(
        onNext: { [weak self] hasAuthorized in
          if hasAuthorized {
            self?.setCurrentPosition()
          } else {
            self?.floatingPanel.move(to: .half, animated: false)
          }
        })
      .disposed(by: disposeBag)

    reactor.state.map { $0.user }
      .distinctUntilChanged()
      .subscribe(
        onNext: { [weak self] user in
          if let user = user {
            let viewController = self?.greetingViewControllerFactory(user)
            self?.floatingPanel.set(contentViewController: viewController)
          } else {
            // handle error
          }
        })
      .disposed(by: disposeBag)

    reactor.state.map { $0.markers }
      .distinctUntilChanged()
      .map { markers in
        markers.map { marker -> NMFMarker in
          let mapMarker = NMFMarker(
            position: .init(
              lat: marker.coordinate.latitude,
              lng: marker.coordinate.longitude
            )
          )
          mapMarker.touchHandler = { [weak self] _ -> Bool in
            let vc = self?.markerViewControllerFactory(marker)
            self?.floatingPanel.set(contentViewController: vc)
            self?.floatingPanel.track(scrollView: vc!.tableView)
            self?.floatingPanel.move(to: .half, animated: true)
            return true
          }
          return mapMarker
        }
      }
      .subscribeOn(MainScheduler.instance)
      .subscribe(
        onNext: { [weak self] markers in
          markers.forEach { marker in
            marker.mapView = self?.mapView
          }
        })
      .disposed(by: disposeBag)
  }
}

extension MainViewController: NMFMapViewCameraDelegate {
  func initalizeNMapsMap() {
    self.mapView.addCameraDelegate(delegate: self)
  }

  func setCurrentPosition() {
    self.mapView.positionMode = .compass
  }

  func mapViewCameraIdle(_ mapView: NMFMapView) {
    reactor?.action.onNext(
      .fetchNearbyClips(
        mapView.latitude,
        mapView.longitude
      )
    )
  }
}
