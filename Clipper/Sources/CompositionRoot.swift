//
//  CompositionRoot.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/10/27.
//

import UIKit

import GoogleSignIn
import Hero
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

    let navigator = Navigator(window: window)
    let authService = AuthService()

    let authPlugin = AuthPlugin(authService: authService)
    let clipperProvider = MoyaProvider<ClipperAPI>(plugins: [authPlugin])

    let userService = UserService(provider: clipperProvider)
    let locationService = LocationService()
    let clipService = ClipService(provider: clipperProvider)
    let markerService = MarkerService(provider: clipperProvider)

    let mainViewReactor = MainViewReactor(
      userService: userService,
      locationService: locationService,
      markerService: markerService
    )
    let mainViewController = MainViewController(
      reactor: mainViewReactor,
      greetingViewControllerFactory: { user in
        let reactor = GreetingViewReactor(
          user: user,
          locationService: locationService
        )
        return GreetingViewController(reactor: reactor)
      },
      markerViewControllerFactory: { marker in
        let reactor = MarkerViewReactor(
          marker: marker,
          clipService: clipService,
          markerViewLocaionCellReactorFactory: MarkerViewLocationCellReactor.init,
          markerViewItemCellReactorFactory: MarkerViewItemCellReactor.init
        )
        return MarkerViewController(
          reactor: reactor,
          newClipViewControllerFactory: { marker in
            let reactor = NewClipViewReactor(
              marker: marker,
              clipService: clipService,
              markerService: markerService
            )
            return NewClipViewController(reactor: reactor)
          },
          clipListViewContollerFactory: { markerID in
            let reactor = ClipListViewReactor(
              marker: markerID,
              clipService: clipService,
              clipCellReactorFactory: ClipCellReactor.init
            )
            return ClipListViewController(reactor: reactor)
          }
        )
      })

    let presentMainScreen = {
      UIView.transition(
        with: window,
        duration: 0.3,
        options: .transitionFlipFromLeft,
        animations: {
          navigator.root(mainViewController)
        }
      )
    }

    let signInViewReactor = SignInViewReactor(
      userService: userService,
      authService: authService
    )
    let signInViewController = SignInViewController(
      reactor: signInViewReactor,
      presentMainScreen: presentMainScreen,
      signUpViewControllerFactory: { token in
        let reactor = SignUpViewReactor(
          userService: userService,
          authService: authService,
          token: token
        )
        let viewController = SignUpViewController(
          reactor: reactor,
          presentMainScreen: presentMainScreen
        )
        viewController.hero.isEnabled = true
        return viewController
      }
    )
    signInViewController.hero.isEnabled = true

    let presentLoginScreen = {
      UIView.transition(
        with: window,
        duration: 0.3,
        options: .transitionFlipFromRight,
        animations: {
          let signInViewController = BaseNavigationController(rootViewController: signInViewController)
          navigator.root(signInViewController)
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
    GIDSignIn.sharedInstance().clientID = "594526153431-20fhpqjscu9pb4n6sqgqgrbi2o1o8q4u.apps.googleusercontent.com"
    NMFAuthManager.shared().clientId = "mk865lle23"
  }

  static func configureAppearance() {
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().tintColor = .black

    UILabel.appearance().textColor = .black

    UIButton.appearance().tintColor = .black
    UIButton.appearance().setTitleColor(.black, for: .normal)
  }
}

