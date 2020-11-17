//
//  Marker.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/11.
//

import Foundation

struct Location: Codable, Equatable {
  let coordinates: [Double]

  var longitude: Double {
    return self.coordinates[0]
  }

  var latitude: Double {
    return self.coordinates[1]
  }
}

struct Marker: Codable, Equatable {
  let id: String?
  let location: Location
  let clips: [Clip]?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case location
    case clips
  }
}
