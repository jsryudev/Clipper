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
  func fetchClips(marker id: String, page: Int, limit: Int) -> Single<Clip>
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

  func fetchClips(marker id: String, page: Int, limit: Int) -> Single<Clip> {
    return self.provider.rx
      .request(.fetchClips(id, page, limit))
      .map(Clip.self)
  }
}
