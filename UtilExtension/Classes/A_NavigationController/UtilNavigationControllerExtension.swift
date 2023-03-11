//
//  UtilNavigationControllerExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UINavigationController {
    /// 推出一个新视图
    /// - Parameters:
    ///   - viewController: 新视图
    ///   - animated: 是否动画推出
    ///   - completion: 推出动画完成后回调
    func pushViewController(
        _ viewController: UIViewController?,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        guard let viewController = viewController else {
            return
        }
        util.pushViewController(viewController, animated: animated)
        callBack(completion: completion)
    }

    /// 退出当前视图
    /// - Parameters:
    ///   - animated: 是否动画退出
    ///   - willPopHandler: 即将退出回调
    ///   - completion: 退出动画完成后回调
    func popViewController(
        animated: Bool = true,
        willPopHandler: (() -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        willPopHandler?()
        util.popViewController(animated: animated)
        callBack(completion: completion)
    }

    /// 退出到指定视图
    /// - Parameters:
    ///   - viewController: 指定视图
    ///   - animated: 是否动画退出
    ///   - willPopHandler: 即将退出
    ///   - completion: 退出动画完成后回调
    func popToViewController(
        _ viewController: UIViewController?,
        animated: Bool = true,
        willPopHandler: ((UIViewController) -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
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
    ///   - animated: 是否动画退出
    ///   - willPopHandler: 即将退出
    ///   - completion: 退出动画完成后回调
    func popToViewControllerFrom(
        classGroup: [AnyClass]?,
        animated: Bool = true,
        willPopHandler: ((UIViewController?) -> Void)? = nil,
        completion: ((UIViewController?) -> Void)? = nil
    ) {
        var targetViewController: UIViewController?
        var popTargetViewController: UIViewController?
        classGroup?.util.forEach { item, _, _, _, stop in
            util.viewControllers.util.forEach { subTtem, _, _, _, subStop in
                if subTtem.children.isEmpty == false {
                    subTtem.children.util.forEach { sub1Ttem, _, _, _, sub1Stop in
                        if sub1Ttem.isKind(of: item) {
                            targetViewController = sub1Ttem
                            popTargetViewController = subTtem
                            sub1Stop(true)
                            subStop(true)
                            stop(true)
                        }
                    }
                } else {
                    if subTtem.isKind(of: item) {
                        targetViewController = subTtem
                        popTargetViewController = subTtem
                        subStop(true)
                        stop(true)
                    }
                }
            }
        }
        willPopHandler?(targetViewController)
        popToViewController(popTargetViewController, animated: animated)
        callBack {
            completion?(targetViewController)
        }
    }

    /// 退出到指定视图
    /// - Parameters:
    ///   - _: 指定视图的 Class
    ///   - animated: 是否动画退出
    ///   - willPopHandler: 即将退出
    ///   - completion: 退出动画完成后回调
    func popToViewControllerFrom<T: UIViewController>(
        _: T.Type,
        animated: Bool = true,
        willPopHandler: ((T?) -> Void)? = nil,
        completion: ((T?) -> Void)? = nil
    ) {
        var targetViewController: T?
        var popTargetViewController: UIViewController?
        util.viewControllers.util.forEach { item, _, _, _, stop in
            if item.children.isEmpty {
                if let viewController = item as? T {
                    targetViewController = viewController
                    popTargetViewController = item
                    stop(true)
                }
            } else {
                item.children.util.forEach { subTtem, _, _, _, subStop in
                    if let viewController = subTtem as? T {
                        targetViewController = viewController
                        popTargetViewController = subTtem
                        subStop(true)
                        stop(true)
                    }
                }
            }
        }
        willPopHandler?(targetViewController)
        popToViewController(popTargetViewController, animated: animated)
        callBack {
            completion?(targetViewController)
        }
    }

    /// 退出到根视图
    /// - Parameters:
    ///   - animated: 是否动画退出
    ///   - completion: 推出动画完成后回调
    func popToRootViewController(
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        util.popToRootViewController(animated: animated)
        callBack(completion: completion)
    }

    /// 在当前控制器栈中删除指定控制器
    /// - Parameter viewController: 需要删除的控制器
    func removeViewController(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        var viewControllers = util.viewControllers
        viewControllers.util.forEach { item, index, _, _, stop in
            if item == viewController {
                viewControllers.remove(at: index)
                stop(true)
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
