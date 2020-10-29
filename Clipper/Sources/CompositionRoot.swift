//
//  CompositionRoot.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

import GoogleSignIn

struct AppDependency {
  let window: UIWindow
  let configureSDKs: () -> Void
  let configureAppearance: () -> Void
}

final class CompositionRoot {
  static func resolve() -> AppDependency {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.makeKeyAndVisible()

    let splashViewReactor = SplashViewReactor()

    let presentMainScreen = {
      UIView.transition(
        with: window,
        duration: 0.3,
        options: .transitionFlipFromLeft,
        animations: {
          window.rootViewController = UIViewController()
        }
      )
    }

    let presentLoginScreen = {
      UIView.transition(
        with: window,
        duration: 0.3,
        options: .transitionFlipFromRight,
        animations: {
          let accountViewReactor = AccountViewReactor()
          let accountViewController = AccountViewController(
            reactor: accountViewReactor,
            presentMainScreen: presentMainScreen
          )
          window.rootViewController = UINavigationController(rootViewController: accountViewController)
        }
      )
    }

    let splashViewController = SplashViewController(
      reactor: splashViewReactor,
      presentLoginScreen: presentLoginScreen,
      presentMainScreen: presentMainScreen
    )

    window.rootViewController = splashViewController

    return AppDependency(
      window: window,
      configureSDKs: self.configureSDKs,
      configureAppearance: self.configureAppearance
    )
  }

  static func configureSDKs() {
    GIDSignIn.sharedInstance().clientID = "594526153431-20fhpqjscu9pb4n6sqgqgrbi2o1o8q4u.apps.googleusercontent.com"
  }

  static func configureAppearance() {
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().tintColor = .clear
  }
}

