//
//  LocationService.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/04.
//

import Foundation

import RxSwift
import CoreLocation
import RxCoreLocation

enum AuthorizationType: Int32 {
  case notDetermined = 0
  case denied = 2
  case authorized = 4
}

protocol LocationServiceType {
  var authorization: Observable<AuthorizationType?> { get }

  func currentAuthorization() -> Observable<AuthorizationType>
  func requestAuthorization()
  func didChangeAuthorization() -> Observable<AuthorizationType>
}

class LocationService: LocationServiceType {
  let manager: CLLocationManager

  init() {
    self.manager = CLLocationManager()
  }

  fileprivate let authorizationSubject = ReplaySubject<AuthorizationType?>.create(bufferSize: 1)
  lazy var authorization: Observable<AuthorizationType?> = self.authorizationSubject.asObservable()
      .startWith(nil)
      .share(replay: 1)

  func requestAuthorization() {
    self.manager.requestWhenInUseAuthorization()
  }

  func currentAuthorization() -> Observable<AuthorizationType> {
    return self.manager.rx
      .status
      .compactMap { AuthorizationType(rawValue: $0.rawValue) }
      .do(
        onNext: { [weak self] authorization in
          self?.authorizationSubject.onNext(authorization)
        })
  }

  func didChangeAuthorization() -> Observable<AuthorizationType> {
    return self.manager.rx
      .didChangeAuthorization
      .compactMap { AuthorizationType(rawValue: $0.status.rawValue) }
      .do(
        onNext: { [weak self] authorization in
          self?.authorizationSubject.onNext(authorization)
        })
  }
}
