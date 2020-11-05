//
//  Clip.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/05.
//

import Foundation

struct Coordinate: Codable {
  let longitude: Double
  let latitude: Double
}

struct Clip: Codable {
  let id: String
  let coordinate: Coordinate
  let location: String
  let title: String
  let content: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case coordinate
    case location
    case title
    case content = "note"
  }
}

