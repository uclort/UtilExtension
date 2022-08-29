//
//  HmScreenExtension.swift
//  Pods-UtilExtension_Example
//
//  Created by 侯猛 on 2022/8/24.
//

import Foundation

public extension HmUtils where Util == UIScreen {
    static var scale: CGFloat {
        UIScreen.main.scale
    }

    /// 设备屏幕宽
    static var width: CGFloat {
        UIScreen.main.bounds.width
    }

    /// 设备屏幕高
    static var height: CGFloat {
        UIScreen.main.bounds.height
    }

    /// 设备屏幕尺寸
    static var size: CGSize {
        UIScreen.main.bounds.size
    }
}
