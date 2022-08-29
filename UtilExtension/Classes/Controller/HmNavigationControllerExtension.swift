//
//  HmNavigationControllerExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/6/24.
//

#if os(iOS)
import UIKit

public extension HmUtils where Util == UINavigationController {
    func pushViewController(_ viewController: UIViewController?,
                            animated: Bool = true,
                            completion: (() -> Void)? = nil)
    {
        guard let viewController = viewController else {
            return
        }
        util.pushViewController(viewController, animated: animated)
        callBack(completion: completion)
    }

    func popViewController(animated: Bool = true,
                           willPopHandler: (() -> Void)? = nil,
                           completion: (() -> Void)? = nil)
    {
        willPopHandler?()
        util.popViewController(animated: animated)
        callBack(completion: completion)
    }

    func popToViewController(_ viewController: UIViewController?,
                             animated: Bool = true,
                             willPopHandler: ((UIViewController) -> Void)? = nil,
                             completion: (() -> Void)? = nil)
    {
        guard let viewController = viewController else {
            popToRootViewController(animated: animated, completion: completion)
            return
        }
        willPopHandler?(viewController)
        util.popToViewController(viewController, animated: animated)
        callBack(completion: completion)
    }

    /// 返回指定控制器
    /// - Parameters:
    ///   - classGroup: 控制器所属类的集合 按照集合顺序返回首次判断到的类
    ///   - animated: 动画返回
    ///   - willPopHandler: 即将跳转
    ///   - completion: 跳完转成
    func popToViewControllerFrom(classGroup: [AnyClass]?,
                                 animated: Bool = true,
                                 willPopHandler: ((UIViewController?) -> Void)? = nil,
                                 completion: ((UIViewController?) -> Void)? = nil)
    {
        var targetViewController: UIViewController?
        var popTargetViewController: UIViewController?
        classGroup?.util.forEach { classValue in
            util.viewControllers.util.forEach { vcValue in
                if vcValue.value.children.isEmpty == false {
                    vcValue.value.children.util.forEach { childVCValue in
                        if childVCValue.value.isKind(of: classValue.value) {
                            targetViewController = childVCValue.value
                            popTargetViewController = vcValue.value
                            childVCValue.stop(true)
                            vcValue.stop(true)
                            classValue.stop(true)
                        }
                    }
                } else {
                    if vcValue.value.isKind(of: classValue.value) {
                        targetViewController = vcValue.value
                        popTargetViewController = vcValue.value
                        vcValue.stop(true)
                        classValue.stop(true)
                    }
                }
            }
        }
        willPopHandler?(targetViewController)
        popToViewController(popTargetViewController)
        callBack {
            completion?(targetViewController)
        }
    }

    func popToViewControllerFrom<T: UIViewController>(_: T.Type,
                                                      animated: Bool = true,
                                                      willPopHandler: ((T?) -> Void)? = nil,
                                                      completion: ((T?) -> Void)? = nil)
    {
        var targetViewController: T?
        var popTargetViewController: UIViewController?
        util.viewControllers.util.forEach { vcValue in
            if vcValue.value.children.isEmpty {
                if let viewController = vcValue.value as? T {
                    targetViewController = viewController
                    popTargetViewController = vcValue.value
                    vcValue.stop(true)
                }
            } else {
                vcValue.value.children.util.forEach { childVCValue in
                    if let viewController = childVCValue.value as? T {
                        targetViewController = viewController
                        popTargetViewController = vcValue.value
                        childVCValue.stop(true)
                        vcValue.stop(true)
                    }
                }
            }
        }
        willPopHandler?(targetViewController)
        popToViewController(popTargetViewController)
        callBack {
            completion?(targetViewController)
        }
    }

    func popToRootViewController(animated: Bool = true,
                                 completion: (() -> Void)? = nil)
    {
        util.popToRootViewController(animated: animated)
        callBack(completion: completion)
    }

    func removeViewController(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        var viewControllers = util.viewControllers
        viewControllers.util.forEach { value in
            if value.value == viewController {
                viewControllers.remove(at: value.index)
                value.stop(true)
            }
        }
        util.viewControllers = viewControllers
    }

    private func callBack(completion: (() -> Void)? = nil) {
        guard let coordinator = util.transitionCoordinator else {
            DispatchQueue.main.async { completion?() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }
}

#endif
