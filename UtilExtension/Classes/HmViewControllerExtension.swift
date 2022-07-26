//
//  HmViewControllerExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/8.
//

#if os(iOS)
import UIKit

public extension HmUtils where Util == UIViewController {
    /** 获取当前控制器 */
    static func current() -> UIViewController? {
        let vc = UIApplication.shared.util.keyWindow?.rootViewController
        return findBest(vc: vc)
    }

    private static func findBest(vc: UIViewController?) -> UIViewController? {
        guard let vc = vc else {
            return nil
        }
        if vc.presentedViewController != nil {
            return findBest(vc: vc.presentedViewController)
        } else if vc.isKind(of: UISplitViewController.self) {
            let svc = vc as! UISplitViewController
            if svc.viewControllers.count > 0 {
                return findBest(vc: svc.viewControllers.last)
            } else {
                return vc
            }
        } else if vc.isKind(of: UINavigationController.self) {
            let svc = vc as! UINavigationController
            if svc.viewControllers.count > 0 {
                return findBest(vc: svc.topViewController)
            } else {
                return vc
            }
        } else if vc.isKind(of: UITabBarController.self) {
            let svc = vc as! UITabBarController
            if (svc.viewControllers?.count ?? 0) > 0 {
                return findBest(vc: svc.selectedViewController)
            } else {
                return vc
            }
        } else {
            return vc
        }
    }
}
#endif
