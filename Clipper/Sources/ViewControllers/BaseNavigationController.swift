//
//  BaseNavigationController.swift
//  Clipper
//
//  Created by JunSang Ryu on 2020/11/02.
//

import UIKit

import Hero

final class BaseNavigationController: UINavigationController {
  
  fileprivate let heroTransition = HeroTransition()
  
  override func viewDidLoad() {
    self.delegate = self
    self.hero.navigationAnimationType = .selectBy(
      presenting: .pageIn(direction: .left),
      dismissing: .pageOut(direction: .right)
    )
  }
}

// MARK: NavigationControllerDelegate
extension BaseNavigationController: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
  ) -> UIViewControllerInteractiveTransitioning? {
    return heroTransition.navigationController(navigationController, interactionControllerFor: animationController)
  }
  
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return heroTransition.navigationController(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
  }
}
