//
//  User.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/30.
//

import Foundation

struct User: Codable {
  let id: String
  let name: String
  let accessToken: String

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case name
    case accessToken
  }
}
