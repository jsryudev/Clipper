//
//  CompositionRoot.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

import GoogleSignIn
import Moya
import NMapsMap

struct AppDependency {
  let window: UIWindow
  let configureSDKs: () -> Void
  let configureAppearance: () -> Void
}

final class CompositionRoot {
  static func resolve() -> AppDependency {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.makeKeyAndVisible()

    let clipperProvider = MoyaProvider<ClipperAPI>()
    let userService = UserService(provider: clipperProvider)
    let authService = AuthService()

    let presentMainScreen = {
      UIView.transition(
        with: window,
        duration: 0.3,
        options: .transitionFlipFromLeft,
        animations: {
          window.rootViewController = UIViewController()
          authService.signOut()
        }
      )
    }

    let presentLoginScreen = {
      UIView.transition(
        with: window,
        duration: 0.3,
        options: .transitionFlipFromRight,
        animations: {
          let signInViewReactor = SignInViewReactor(
            userService: userService,
            authService: authService
          )
          let signInViewController = SignInViewController(
            reactor: signInViewReactor,
            presentMainScreen: presentMainScreen
          )
          window.rootViewController = UINavigationController(rootViewController: signInViewController)
        }
      )
    }

    let splashViewReactor = SplashViewReactor(authService: authService)
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
    NMFAuthManager.shared().clientId = "mk865lle23"
    GIDSignIn.sharedInstance().clientID = "594526153431-20fhpqjscu9pb4n6sqgqgrbi2o1o8q4u.apps.googleusercontent.com"
  }

  static func configureAppearance() {
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().tintColor = .clear
  }
}

