//
//  AppDelegate.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

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
    self.window = self.dependency.window
    return true
  }
}

