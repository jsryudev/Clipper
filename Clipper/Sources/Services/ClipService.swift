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
  func fetchClips(marker id: String, page: Int, limit: Int) -> Single<[Clip]>
  func createClip(latitude: Double, longitude: Double, title: String, content: String) -> Single<Bool>
}

final class ClipService: ClipServiceType {
  let provider: MoyaProvider<ClipperAPI>

  init(provider: MoyaProvider<ClipperAPI>) {
    self.provider = provider
  }

  func fetchClips(marker id: String, page: Int, limit: Int) -> Single<[Clip]> {
    return self.provider.rx
      .request(.fetchClips(id, page, limit))
      .map([Clip].self)
  }

  func createClip(latitude: Double, longitude: Double, title: String, content: String) -> Single<Bool> {
    return self.provider.rx
      .request(.createClip(latitude, longitude, title, content))
      .map { _ in true }
      .catchErrorJustReturn(false)
  }
}
