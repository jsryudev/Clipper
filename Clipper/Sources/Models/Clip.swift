//
//  Clip.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/05.
//

import Foundation

struct Clip: Codable, Equatable {
  let id: String
  let title: String
  let content: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case title
    case content
  }
}

struct ClipPage: Codable, Equatable {
  let items: [Clip]
  let totalCount: Int
  let totalPages: Int
  let page: Int

  enum CodingKeys: String, CodingKey {
    case items = "docs"
    case totalCount = "totalDocs"
    case totalPages
    case page
  }
}
