//
//  User.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/30.
//

import Foundation

enum UserType: String, Codable {
  case apple
  case google
}

struct User: Codable {
  let type: UserType
  let id: String
  let name: String
  let accessToken: String

  enum CodingKeys: String, CodingKey {
    case type
    case id = "_id"
    case name
    case accessToken
  }
}
