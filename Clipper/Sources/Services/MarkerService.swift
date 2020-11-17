//
//  MarkerService.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/16.
//

import Foundation

import Moya
import RxMoya
import RxSwift

protocol MarkerServiceType {
  func fetchNearby(latitude: Double, longitude: Double) -> Single<[Marker]>
}

final class MarkerService: MarkerServiceType {
  let provider: MoyaProvider<ClipperAPI>

  init(provider: MoyaProvider<ClipperAPI>) {
    self.provider = provider
  }

  func fetchNearby(latitude: Double, longitude: Double) -> Single<[Marker]> {
    return self.provider.rx
      .request(.fetchNearMarkers(latitude, longitude))
      .map([Marker].self)
  }
}
