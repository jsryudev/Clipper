//
//  Marker.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import Foundation

struct Coordinate: Codable, Equatable {
  let longitude: Double
  let latitude: Double
}

struct Marker: Codable, Equatable {
  let id: String
  let coordinate: Coordinate

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case coordinate
  }
}
