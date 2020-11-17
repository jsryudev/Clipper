//
//  Page.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/18.
//

import Foundation

struct Page<T: Codable & Equatable>: Codable, Equatable {
  let totalCount: Int
  let totalPages: Int
  let page: Int
  let items: [T]

  enum CodingKeys: String, CodingKey {
    case items = "docs"
    case totalCount = "totalDocs"
    case totalPages
    case page
  }
}
