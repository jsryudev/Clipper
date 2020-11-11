//
//  ClipService.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/05.
//

import Foundation

import Moya
import RxMoya
import RxSwift

protocol ClipServiceType {
  func fetchNearby(latitude: Double, longitude: Double) -> Single<[Marker]>
}

final class ClipService: ClipServiceType {
  let provider: MoyaProvider<ClipperAPI>

  init(provider: MoyaProvider<ClipperAPI>) {
    self.provider = provider
  }

  func fetchNearby(latitude: Double, longitude: Double) -> Single<[Marker]> {
    return self.provider.rx
      .request(.fetchNearbyMarkers(latitude, longitude))
      .map([Marker].self)
  }
}
