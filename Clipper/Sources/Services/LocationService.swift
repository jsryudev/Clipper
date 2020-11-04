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

protocol LocationServiceType {
  func checkAuthorization() -> Observable<Bool>
}

class LocationService: LocationServiceType {
  let manager: CLLocationManager

  init() {
    self.manager = CLLocationManager()
  }

  func requestPermission() {
    self.manager.requestWhenInUseAuthorization()
  }

  func checkAuthorization() -> Observable<Bool> {
    return self.manager.rx
      .didChangeAuthorization
      .map { $0.status == .authorizedWhenInUse }
      .catchErrorJustReturn(false)
  }
}
