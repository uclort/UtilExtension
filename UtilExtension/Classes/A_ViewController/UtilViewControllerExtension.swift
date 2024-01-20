//
//  UtilViewControllerExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UIViewController {
    /// 获取当前展示的控制器
    static func current() -> UIViewController? {
        let vc = UIApplication.util.keyWindow?.rootViewController
        return findBest(vc: vc, getChildren: false)
    }

    /// 获取当前展示的控制器
    /// 会获取最后添加的子控制器
    static func currentIncludeChildren() -> UIViewController? {
        let vc = UIApplication.util.keyWindow?.rootViewController
        return findBest(vc: vc, getChildren: true)
    }

    private static func findBest(vc: UIViewController?, getChildren: Bool) -> UIViewController? {
        guard let vc = vc else {
            return nil
        }
        if vc.presentedViewController != nil {
            return findBest(vc: vc.presentedViewController, getChildren: getChildren)
        } else if vc.isKind(of: UISplitViewController.self) {
            let svc = vc as! UISplitViewController
            if svc.viewControllers.count > 0 {
                return findBest(vc: svc.viewControllers.last, getChildren: getChildren)
            } else {
                return vc
            }
        } else if vc.isKind(of: UINavigationController.self) {
            let svc = vc as! UINavigationController
            if svc.viewControllers.count > 0 {
                return findBest(vc: svc.topViewController, getChildren: getChildren)
            } else {
                return vc
            }
        } else if vc.isKind(of: UITabBarController.self) {
            let svc = vc as! UITabBarController
            if (svc.viewControllers?.count ?? 0) > 0 {
                return findBest(vc: svc.selectedViewController, getChildren: getChildren)
            } else {
                return vc
            }
        } else if !vc.children.isEmpty, getChildren {
            return vc.children.last
        } else {
            return vc
        }
    }

    /// 删除当前控制器的所有通知
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(util)
    }

    /// 设置导航栏透明
    func configNavigationBarTransparent() {
        if #available(iOS 13, *) {
            guard let barAppearance = util.navigationController?.navigationBar.standardAppearance else { return }
            barAppearance.backgroundColor = .clear
            barAppearance.backgroundImage = nil
            barAppearance.backgroundEffect = nil
            barAppearance.shadowImage = nil
            barAppearance.shadowColor = .clear
            util.navigationController?.navigationBar.standardAppearance = barAppearance
            util.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            util.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            util.navigationController?.navigationBar.shadowImage = UIImage()
        }
        util.navigationController?.navigationBar.isTranslucent = true
    }

    /// 设置导航栏为默认主题样式
    /// 背景色 3D3D3D
    /// 底部分割线 4C4C4C
    func configNavigationBarDefaultStyle() {
        configNavigationBarBackgroundColor(color: .util.themeColor)
        configNavigationBarBottomLine(color: .util.navigationBarBottomLineColor)
        configNavigationBarTitleStyle(color: .white)
    }

    /// 设置导航栏为白色背景样式
    /// 背景色 纯白
    /// 底部分割线 透明
    func configNavigationBarWhiteStyle() {
        configNavigationBarBackgroundColor(color: .white)
        hiddenNavigationBarBottomLine()
        configNavigationBarTitleStyle(color: .util.textColor)
    }

    /// 隐藏导航栏底部分割线
    func hiddenNavigationBarBottomLine() {
        if #available(iOS 13, *) {
            guard let standardAppearance = util.navigationController?.navigationBar.standardAppearance else { return }
            standardAppearance.shadowColor = .clear
            standardAppearance.shadowImage = nil
            util.navigationController?.navigationBar.standardAppearance = standardAppearance
            util.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        } else {
            util.navigationController?.navigationBar.shadowImage = UIImage.util.create(color: .clear)
        }
    }

    /// 显示导航栏底部分割线
    /// - Parameter color: 分割线颜色
    func showNavigationBarBottomLine(color: UIColor = .util.navigationBarBottomLineColor) {
        let lineMainView = UIView(frame: .init(x: 0, y: 1.0 - (1.0 / UIScreen.util.scale), width: UIScreen.util.width, height: 1.0))
        lineMainView.backgroundColor = .clear
        let lineView = UIView(frame: .init(x: 0, y: 0, width: UIScreen.util.width, height: 1.0))
        lineView.backgroundColor = color
        lineMainView.addSubview(lineView)
        let shadowImage = lineMainView.util.makeImageWithView(false)?.withRenderingMode(.alwaysOriginal)
        if #available(iOS 13, *), let barAppearance = util.navigationController?.navigationBar.standardAppearance {
            barAppearance.shadowColor = .clear
            barAppearance.shadowImage = shadowImage
            util.navigationController?.navigationBar.standardAppearance = barAppearance
            util.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            util.navigationController?.navigationBar.shadowImage = shadowImage
        }
    }

    /// 设置导航栏底部分割线颜色
    /// - Parameters:
    ///   - color: 线颜色
    ///   - leftInset: 左边距
    ///   - rightInset: 右边距
    ///   - height: 线高
    func configNavigationBarBottomLine(
        color: UIColor,
        leftInset: CGFloat = 0,
        rightInset: CGFloat = 0,
        height: CGFloat = 1.0
    ) {
        let lineMainView = UIView(frame: .init(x: 0, y: height - (1.0 / UIScreen.util.scale), width: UIScreen.util.width, height: height))
        lineMainView.backgroundColor = .clear
        let lineView = UIView(frame: .init(x: leftInset, y: 0, width: UIScreen.util.width - (leftInset + rightInset), height: height))
        lineView.backgroundColor = color
        lineMainView.addSubview(lineView)
        let shadowImage = lineMainView.util.makeImageWithView(false)?.withRenderingMode(.alwaysOriginal)
        if #available(iOS 13, *), let barAppearance = util.navigationController?.navigationBar.standardAppearance {
            barAppearance.shadowColor = .clear
            barAppearance.shadowImage = shadowImage
            util.navigationController?.navigationBar.standardAppearance = barAppearance
            util.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            util.navigationController?.navigationBar.shadowImage = shadowImage
        }
    }

    /// 设置导航栏背景颜色
    /// - Parameter color: 颜色
    func configNavigationBarBackgroundColor(color: UIColor) {
        if #available(iOS 13, *) {
            guard let barAppearance = util.navigationController?.navigationBar.standardAppearance else { return }
            barAppearance.backgroundColor = color
            util.navigationController?.navigationBar.standardAppearance = barAppearance
            util.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            util.navigationController?.navigationBar.barTintColor = color
        }
        util.navigationController?.navigationBar.isTranslucent = false
    }

    /// 设置导航栏背景图片
    func configNavigationBarBackgroundImage(image: UIImage?) {
        if #available(iOS 13, *) {
            guard let barAppearance = util.navigationController?.navigationBar.standardAppearance else { return }
            barAppearance.backgroundImage = image
            util.navigationController?.navigationBar.standardAppearance = barAppearance
            util.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            util.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        }
    }

    /// 设置导航栏文字样式
    func configNavigationBarTitleStyle(color: UIColor, font: UIFont = .boldSystemFont(ofSize: 16)) {
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font,
        ]
        if #available(iOS 13, *) {
            guard let barAppearance = util.navigationController?.navigationBar.standardAppearance else { return }
            barAppearance.titleTextAttributes = titleTextAttributes
            util.navigationController?.navigationBar.standardAppearance = barAppearance
            util.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            util.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        }
    }

    /// 设置左上角返回按钮
    /// - Parameters:
    ///   - darkColor: 是否为深色 true 黑色箭头 false 白色箭头 默认 false
    ///   - target: 执行对象 可不传
    ///   - action: 执行方法 可不传
    func setupBackBarButtonItem(
        darkColor: Bool = false,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        let image: UIImage? = darkColor ? .util.blackBackImage : .util.whiteBackImage
        let target = target ?? util
        let action = action ?? #selector(util.backPreviousPage)
        let backBarButtonItem = UIBarButtonItem(
            image: image?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: target,
            action: action
        )
        util.navigationItem.leftBarButtonItem = backBarButtonItem
    }

    /// 删除所有子控制器及视图
    func removeAllChild() {
        util.children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }

    @discardableResult
    /// 删除子控制器
    /// - Parameter _: 子控制器类型
    /// - Returns: 被删除的子控制器
    func removeChild<T: UIViewController>(_: T.Type) -> UIViewController? {
        let targetVC = util.children.first { $0 is T }
        targetVC?.view.removeFromSuperview()
        targetVC?.removeFromParent()
        return targetVC
    }

    /// 获取子控制器
    /// - Parameter _: 子控制器类型
    /// - Returns: 子控制器
    func getChild<T: UIViewController>(_: T.Type) -> UIViewController? {
        util.children.first { $0 is T }
    }
}

private extension UIViewController {
    /// 返回上一页面
    @objc func backPreviousPage() {
        navigationController?.popViewController(animated: true)
    }
}

public extension UclortExtensionVariableUtil where Util: UIViewController {
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
        util.navigationController?.util.pushViewController(viewController, animated: animated, completion: completion)
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
        util.navigationController?.util.popViewController(animated: animated, willPopHandler: willPopHandler, completion: completion)
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
        util.navigationController?.util.popToViewController(viewController, animated: animated, willPopHandler: willPopHandler, completion: completion)
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
        util.navigationController?.util.popToViewControllerFrom(classGroup: classGroup, animated: animated, willPopHandler: willPopHandler, completion: completion)
    }

    /// 退出到指定视图
    /// - Parameters:
    ///   - _: 指定视图的 Class
    ///   - animated: 是否动画退出
    ///   - willPopHandler: 即将退出
    ///   - completion: 退出动画完成后回调
    func popToViewControllerFrom<T: UIViewController>(
        _ type: T.Type,
        animated: Bool = true,
        willPopHandler: ((T?) -> Void)? = nil,
        completion: ((T?) -> Void)? = nil
    ) {
        util.navigationController?.util.popToViewControllerFrom(type, animated: animated, willPopHandler: willPopHandler, completion: completion)
    }

    /// 退出到根视图
    /// - Parameters:
    ///   - animated: 是否动画退出
    ///   - completion: 推出动画完成后回调
    func popToRootViewController(
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        util.navigationController?.util.popToRootViewController(animated: animated, completion: completion)
    }

    /// 在当前控制器栈中删除指定控制器
    /// - Parameter viewController: 需要删除的控制器
    func removeViewController(_ viewController: UIViewController?) {
        util.navigationController?.util.removeViewController(viewController)
    }
}

// MARK: NavigationItem Config Left
public extension UclortExtensionVariableUtil where Util: UIViewController {
    /// 配置导航栏左按钮
    /// - Parameters:
    ///   - customView: 自定义视图
    ///   - title: 标题
    ///   - image: 图片
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    private func configLeftNavigationItemBarButtonItem_Base(
        customView: UIView? = nil,
        title: String? = nil,
        image: UIImage? = nil,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        if let customView {
            util.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
        } else if let title {
            util.navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: style, target: target, action: action)
        } else if let image {
            util.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: style, target: target, action: action)
        }
    }

    /// 配置左侧导航栏自定义视图按钮
    /// - Parameter customView: 自定义视图
    func configLeftNavigationItemBarButtonItem(
        customView: UIView
    ) {
        configLeftNavigationItemBarButtonItem_Base(customView: customView)
    }

    /// 配置左侧导航栏文字按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    func configLeftNavigationItemBarButtonItem(
        title: String,
        style: UIBarButtonItem.Style = .plain,
        target: Any?,
        action: Selector?
    ) {
        configLeftNavigationItemBarButtonItem_Base(title: title, style: style, target: target, action: action)
    }

    /// 配置左侧导航栏图片按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    func configLeftNavigationItemBarButtonItem(
        image: UIImage?,
        style: UIBarButtonItem.Style = .plain,
        target: Any?,
        action: Selector?
    ) {
        configLeftNavigationItemBarButtonItem_Base(image: image, style: style, target: target, action: action)
    }

    /// 删除所有左侧导航栏按钮
    func removeAllLeftBarButtonItems() {
        util.navigationItem.leftBarButtonItems = []
    }
}

// MARK: NavigationItem Config Right
public extension UclortExtensionVariableUtil where Util: UIViewController {
    /// 配置导航栏右按钮
    /// - Parameters:
    ///   - customView: 自定义视图
    ///   - title: 标题
    ///   - image: 图片
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    private func configRightNavigationItemBarButtonItem_Base(
        customView: UIView? = nil,
        title: String? = nil,
        image: UIImage? = nil,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        if let customView {
            util.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView)
        } else if let title {
            util.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: style, target: target, action: action)
        } else if let image {
            util.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: style, target: target, action: action)
        }
    }

    /// 配置左侧导航栏自定义视图按钮
    /// - Parameter customView: 自定义视图
    func configRightNavigationItemBarButtonItem(
        title: String,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        configRightNavigationItemBarButtonItem_Base(title: title, style: style, target: target, action: action)
    }

    /// 配置左侧导航栏文字按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    func configRightNavigationItemBarButtonItem(
        image: UIImage?,
        style: UIBarButtonItem.Style = .plain,
        target: Any?,
        action: Selector?
    ) {
        configRightNavigationItemBarButtonItem_Base(image: image, style: style, target: target, action: action)
    }

    /// 配置左侧导航栏图片按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    func configRightNavigationItemBarButtonItem(
        customView: UIView
    ) {
        configRightNavigationItemBarButtonItem_Base(customView: customView)
    }

    /// 删除所有左侧导航栏按钮
    func removeAllRightBarButtonItems() {
        util.navigationItem.rightBarButtonItems = []
    }
}

// MARK: NavigationItem Add Left
public extension UclortExtensionVariableUtil where Util: UIViewController {
    /// 新增导航栏左按钮
    /// - Parameters:
    ///   - customView: 自定义视图
    ///   - title: 标题
    ///   - image: 图片
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    private func addLeftNavigationItemBarButtonItem_Base(
        customView: UIView? = nil,
        title: String? = nil,
        image: UIImage? = nil,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        var barButtonItems = util.navigationItem.leftBarButtonItems ?? []
        var barButtonItem: UIBarButtonItem?
        if let customView {
            barButtonItem = UIBarButtonItem(customView: customView)
        } else if let title {
            barButtonItem = UIBarButtonItem(title: title, style: style, target: target, action: action)
        } else if let image {
            barButtonItem = UIBarButtonItem(image: image, style: style, target: target, action: action)
        }
        guard let barButtonItem else {
            return
        }
        barButtonItems.append(barButtonItem)
        util.navigationItem.leftBarButtonItems = barButtonItems
    }

    /// 新增左侧导航栏自定义视图按钮
    /// - Parameter customView: 自定义视图
    func addLeftNavigationItemBarButtonItem(
        customView: UIView
    ) {
        addLeftNavigationItemBarButtonItem_Base(customView: customView)
    }

    /// 新增左侧导航栏文字按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    func addLeftNavigationItemBarButtonItem(
        title: String,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        addLeftNavigationItemBarButtonItem_Base(title: title, style: style, target: target, action: action)
    }

    /// 新增左侧导航栏图片按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    func addLeftNavigationItemBarButtonItem(
        image: UIImage?,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        addLeftNavigationItemBarButtonItem_Base(image: image, style: style, target: target, action: action)
    }
}

// MARK: NavigationItem Add Right
public extension UclortExtensionVariableUtil where Util: UIViewController {
    /// 新增导航栏右按钮
    /// - Parameters:
    ///   - customView: 自定义视图
    ///   - title: 标题
    ///   - image: 图片
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    private func addRightNavigationItemBarButtonItem_Base(
        customView: UIView? = nil,
        title: String? = nil,
        image: UIImage? = nil,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        var barButtonItems = util.navigationItem.rightBarButtonItems ?? []
        var barButtonItem: UIBarButtonItem?
        if let customView {
            barButtonItem = UIBarButtonItem(customView: customView)
        } else if let title {
            barButtonItem = UIBarButtonItem(title: title, style: style, target: target, action: action)
        } else if let image {
            barButtonItem = UIBarButtonItem(image: image, style: style, target: target, action: action)
        }
        guard let barButtonItem else {
            return
        }
        barButtonItems.append(barButtonItem)
        util.navigationItem.rightBarButtonItems = barButtonItems
    }

    /// 新增右侧导航栏自定义视图按钮
    /// - Parameter customView: 自定义视图
    func addRightNavigationItemBarButtonItem(
        customView: UIView
    ) {
        addRightNavigationItemBarButtonItem_Base(customView: customView)
    }

    /// 新增右侧导航栏文字按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    func addRightNavigationItemBarButtonItem(
        title: String,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        addRightNavigationItemBarButtonItem_Base(title: title, style: style, target: target, action: action)
    }

    /// 新增右侧导航栏图片按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 类型
    ///   - target: 目标
    ///   - action: 目标选择器
    func addRightNavigationItemBarButtonItem(
        image: UIImage?,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        addRightNavigationItemBarButtonItem_Base(image: image, style: style, target: target, action: action)
    }
}

// MARK: AlertController
public extension UclortExtensionVariableUtil where Util: UIViewController {
    @discardableResult
    /// 推出系统样式弹窗
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗内容
    ///   - preferredStyle: 弹窗类型
    ///   - actions: 事件按钮集合
    ///   - cancelActionTitle: 取消按钮 title
    ///     - 默认 nil 没有取消按钮
    ///   - preferredActionIndex: 首选按钮 高亮
    ///     - 默认 nil 没有高亮按钮
    ///   - cancelHandler: 取消按钮执行事件
    func showAlertController(
        title: String?,
        message: String? = nil,
        preferredStyle: UIAlertController.Style,
        actions: [UIAlertAction] = [],
        cancelActionTitle: String? = nil,
        preferredActionIndex: Int? = nil,
        cancelHandler: (() -> Void)? = nil
    ) -> UIAlertController {
        var actions = actions
        if let cancelActionTitle {
            actions.append(UIAlertAction(title: cancelActionTitle, style: .cancel, handler: { _ in
                cancelHandler?()
            }))
        }
        if actions.isEmpty {
            actions.append(UIAlertAction(title: "确定", style: .default))
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.util.forEach { action, index, _, _, _ in
            alertController.addAction(action)
            if let preferredActionIndex, index == preferredActionIndex {
                alertController.preferredAction = action
            }
        }
        util.present(alertController, animated: true, completion: nil)
        return alertController
    }

    @discardableResult
    /// 推出系统样式弹窗
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗内容
    ///   - actionTitles: 事件按钮标题集合
    ///   - cancelActionTitle: 取消按钮 title
    ///     - 默认 nil 没有取消按钮
    ///   - preferredActionIndex: 首选按钮 高亮
    ///     - 默认 nil 没有高亮按钮
    ///   - actionHandler: 事件按钮执行事件
    ///   - cancelHandler: 取消按钮执行事件
    func showAlert(
        title: String?,
        message: String? = nil,
        actionTitles: [String] = [],
        cancelActionTitle: String? = nil,
        preferredActionIndex: Int? = nil,
        actionHandler: ((_ index: Int, _ title: String) -> Void)? = nil,
        cancelHandler: (() -> Void)? = nil
    ) -> UIAlertController {
        var actions: [UIAlertAction] = []
        actionTitles.util.forEach { title, index, _, _, _ in
            let action = UIAlertAction(title: title, style: .default) { _ in
                actionHandler?(index, title)
            }
            actions.append(action)
        }
        return showAlertController(
            title: title,
            message: message,
            preferredStyle: .alert,
            actions: actions,
            cancelActionTitle: cancelActionTitle,
            preferredActionIndex: preferredActionIndex,
            cancelHandler: cancelHandler
        )
    }

    @discardableResult
    /// 推出系统样式弹窗
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗内容
    ///   - action: 事件按钮集合
    ///   - preferredActionIndex: 首选按钮 高亮
    func showAlert(
        title: String?,
        message: String? = nil,
        actions: [UIAlertAction] = [],
        preferredActionIndex: Int? = nil
    ) -> UIAlertController {
        return showAlertController(
            title: title,
            message: message,
            preferredStyle: .alert,
            actions: actions,
            preferredActionIndex: preferredActionIndex
        )
    }

    @discardableResult
    /// 推出系统样式 actionSheet
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗内容
    ///   - actionTitles: 事件按钮标题集合
    ///   - cancelActionTitle: 取消按钮 title
    ///     - 默认 nil 没有取消按钮
    ///   - actionHandler: 事件按钮执行事件
    ///   - cancelHandler: 取消按钮执行事件
    func showActionSheet(
        title: String?,
        message: String? = nil,
        actionTitles: [String] = [],
        cancelActionTitle: String? = nil,
        actionHandler: ((_ index: Int, _ title: String) -> Void)? = nil,
        cancelHandler: (() -> Void)? = nil
    ) -> UIAlertController {
        var actions: [UIAlertAction] = []
        actionTitles.util.forEach { title, index, _, _, _ in
            let action = UIAlertAction(title: title, style: .default) { _ in
                actionHandler?(index, title)
            }
            actions.append(action)
        }
        return showAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet,
            actions: actions,
            cancelActionTitle: cancelActionTitle,
            cancelHandler: cancelHandler
        )
    }

    @discardableResult
    /// 推出系统样式 actionSheet
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗内容
    ///   - action: 事件按钮集合
    func showActionSheet(
        title: String?,
        message: String? = nil,
        actions: [UIAlertAction] = []
    ) -> UIAlertController {
        return showAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet,
            actions: actions
        )
    }
}
