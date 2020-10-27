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

    return AppDependency(
      window: window,
      configureSDKs: self.configureSDKs
    )
  }

  static func configureSDKs() {
    // do something
  }
}
