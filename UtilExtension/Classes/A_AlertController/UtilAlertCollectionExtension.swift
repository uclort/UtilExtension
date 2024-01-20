//
//  UtilAlertCollectionExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

#if canImport(AudioToolbox)
import AudioToolbox
#endif

public extension UclortExtensionVariableUtil where Util == UIAlertController {
    
    @discardableResult
    /// 新增执行控件
    /// - Parameters:
    ///   - title: 执行标题
    ///   - style: 执行类型
    ///   - isEnabled: 是否可用
    ///   - handler: 执行回调
    /// - Returns: 执行控件
    func addAction(
        title: String,
        style: UIAlertAction.Style = .default,
        isEnabled: Bool = true,
        handler: ((UIAlertAction) -> Void)? = nil
    ) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        util.addAction(action)
        return action
    }

    /// 展示弹出提示控件
    /// - Parameters:
    ///   - animated: 动画弹出
    ///   - vibrate: 弹出同时是否震动设备
    ///   - completion: 弹出完成后回调
    func show(
        animated: Bool = true,
        vibrate: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        #if targetEnvironment(macCatalyst)
        let window = UIApplication.shared.windows.last
        #else
        let window = UIApplication.shared.keyWindow
        #endif
        window?.rootViewController?.present(util, animated: animated, completion: completion)
        if vibrate {
            #if canImport(AudioToolbox)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            #endif
        }
    }
}
