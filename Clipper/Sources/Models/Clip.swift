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
