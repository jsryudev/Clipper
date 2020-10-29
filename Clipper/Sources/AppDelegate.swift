//
//  AppDelegate.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var dependency: AppDependency!

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.dependency = self.dependency ?? CompositionRoot.resolve()
    self.dependency.configureSDKs()
    self.dependency.configureAppearance()
    self.window = self.dependency.window
    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance().handle(url)
  }
}
