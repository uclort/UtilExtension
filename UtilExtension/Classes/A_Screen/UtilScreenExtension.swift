//
//  UtilScreenExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/24.
//

import Foundation

public extension UclortExtensionVariableUtil where Util == UIScreen {
    /// 屏幕像素缩放比
    static var scale: CGFloat {
        UIApplication.util.screen.scale
    }

    /// 设备屏幕宽
    static var width: CGFloat {
        UIApplication.util.screen.bounds.width
    }

    /// 设备屏幕高
    static var height: CGFloat {
        UIApplication.util.screen.bounds.height
    }

    /// 设备屏幕尺寸
    static var size: CGSize {
        UIApplication.util.screen.bounds.size
    }
    
    /// 设备屏幕中心位置
    static var center: CGPoint {
        CGPoint(x: width * 0.5, y: height * 0.5)
    }
    
    /// 一像素 = CGFloat(0.5)
    ///
    /// 不同的设备 scale 值不同
    /// 高分屏绘制不出真正的 0.5 像素
    /// 所以使用缩放比去设置
    /// 涉及到 0.5 尺寸的值都用此
    /// !!!代码审核必审项
    ///
    /// https://www.jianshu.com/p/d9f5e0aabcdb
    static var onePixel: CGFloat {
        1.0 / UIScreen.util.scale
    }

    /// 导航栏尺寸
    static var statusBarFrame: CGRect {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        } else {
            return UIApplication.shared.statusBarFrame
        }
    }

    /// 导航栏高度
    static var statusBarHeight: CGFloat {
        statusBarFrame.height
    }

    /// 顶部安全区域高度
    static var safeTopHeight: CGFloat {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return 0.0 }
            return window.safeAreaInsets.top
        } else if #available(iOS 11, *) {
            guard let window = UIApplication.shared.windows.first else { return 0.0 }
            return window.safeAreaInsets.top
        }
        return 0.0
    }

    /// 底部安全区域高度
    static var safeBottomHeight: CGFloat {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return 0.0 }
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11, *) {
            guard let window = UIApplication.shared.windows.first else { return 0.0 }
            return window.safeAreaInsets.bottom
        }
        return 0.0
    }

    /// 导航栏高度
    static var navigationBarHeight: CGFloat {
        44.0
    }

    /// 标签栏高度
    static var tabBarHeight: CGFloat {
        49.0
    }
    
    /// 导航栏+顶部安全区域高度
    static var safeTopNavigationBarHeight: CGFloat {
        navigationBarHeight + safeTopHeight
    }
    
    /// 标签栏+底部安全区域高度
    static var safeBottomTabBarHeight: CGFloat {
        tabBarHeight + safeBottomHeight
    }
    
    /// 状态栏 + 导航栏高度
    static var statusNavigationBarHeight: CGFloat {
        statusBarHeight + navigationBarHeight
    }
}
