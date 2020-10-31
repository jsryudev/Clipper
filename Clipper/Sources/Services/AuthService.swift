//
//  AuthService.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/30.
//

import Foundation

import KeychainAccess
import GoogleSignIn

protocol AuthServiceType {
  var accessToken: String? { get set }
  func signOut()
  func save(token: String?)
}

// FIXME
final class AuthService: AuthServiceType {
  private var _accessToken: String?
  var accessToken: String? {
    get {
      return _accessToken ?? load()
    }
    set {
      self._accessToken = newValue
      self.save(token: newValue)
    }
  }

  fileprivate let keychain = Keychain(service: "dev.jsryu.clipper")

  init() {
    self._accessToken = self.load()
  }

  func signOut() {
    self.accessToken = nil
    GIDSignIn.sharedInstance().signOut()
    delete()
  }

  func save(token: String?) {
    guard let accessToken = token else { return }
    try? self.keychain.set(accessToken, key: "access_token")
    self.accessToken = nil
  }

  fileprivate func load() -> String? {
    guard let accessToken = self.keychain["access_token"] else { return nil }
    return accessToken
  }

  fileprivate func delete() {
    try? self.keychain.remove("access_token")
  }
}

