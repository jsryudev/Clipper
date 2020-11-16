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
  func fetchClips(marker id: String, page: Int, limit: Int) -> Single<Clip>
}

final class ClipService: ClipServiceType {
  let provider: MoyaProvider<ClipperAPI>

  init(provider: MoyaProvider<ClipperAPI>) {
    self.provider = provider
  }

  func fetchClips(marker id: String, page: Int, limit: Int) -> Single<Clip> {
    return self.provider.rx
      .request(.fetchClips(id, page, limit))
      .map(Clip.self)
  }
}
