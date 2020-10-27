//
//  CompositionRoot.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

struct AppDependency {
  let window: UIWindow
  let configureSDKs: () -> Void
}

final class CompositionRoot {
  static func resolve() -> AppDependency {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.makeKeyAndVisible()

    let splashViewReactor = SplashViewReactor()

    let presentLoginScreen = {
      window.rootViewController = UIViewController()
    }

    let presentMainScreen = {
      window.rootViewController = UIViewController()
    }

    let splashViewController = SplashViewController(
      reactor: splashViewReactor,
      presentLoginScreen: presentLoginScreen,
      presentMainScreen: presentMainScreen
    )
    window.rootViewController = splashViewController

    return AppDependency(
      window: window,
      configureSDKs: self.configureSDKs
    )
  }

  static func configureSDKs() {
    // do something
  }
}
