//
//  Navigator.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/18.
//

import UIKit

final class Navigator {
  typealias NavigatorCompletionBlock = (() -> Void)
  fileprivate let window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }

  func current() -> UIViewController? {
    guard let root = self.window.rootViewController else { return nil }
    return root.presentingViewController
  }

  func root(_ viewController: UIViewController) {
    self.window.rootViewController = viewController
  }

  func present(_ viewController: UIViewController, animated: Bool = true, completion: NavigatorCompletionBlock? = nil) {
    guard let root = self.window.rootViewController else { return }
    root.present(viewController, animated: animated, completion: completion)
  }

  func show(_ viewController: UIViewController, sender: Any? = nil) {
    guard let root = self.window.rootViewController else { return }
    root.show(viewController, sender: sender)
  }
}
