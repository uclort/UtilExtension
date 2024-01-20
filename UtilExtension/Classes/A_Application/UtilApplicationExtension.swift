//
//  UtilApplicationExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public enum UtilStatusBarStyle {
    /// 亮色模式 -> 文字为白色
    case light
    /// 深色模式 -> 文字为黑色
    case dark
}

public extension UclortExtensionVariableUtil where Util == UIApplication {
    /// App 根窗口
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            guard let scenes = (UIApplication.shared.connectedScenes as? Set<UIWindowScene>) else {
                return nil
            }
            for windowScene: UIWindowScene in scenes {
                if windowScene.activationState == .foregroundActive {
                    return windowScene.windows.first
                }
            }
        } else {
            return UIApplication.shared.keyWindow
        }
        return UIApplication.shared.delegate?.window ?? nil
    }
    
    /// 用户界面
    static var screen: UIScreen {
        if #available(iOS 16, *) {
            if let screen = keyWindow?.windowScene?.screen {
                return screen
            }
            return UIScreen.main
        } else {
            return UIScreen.main
        }
    }

    enum Environment {
        case debug
        case testFlight
        case appStore
    }

    /// 当前 App 环境
    static var inferredEnvironment: Environment {
        #if DEBUG
        return .debug

        #elseif targetEnvironment(simulator)
        return .debug

        #else
        if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
            return .testFlight
        }

        guard let appStoreReceiptUrl = Bundle.main.appStoreReceiptURL else {
            return .debug
        }

        if appStoreReceiptUrl.lastPathComponent.lowercased() == "sandboxreceipt" {
            return .testFlight
        }

        if appStoreReceiptUrl.path.lowercased().contains("simulator") {
            return .debug
        }

        return .appStore
        #endif
    }

    /// App 名称
    static var displayName: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    /// App 构建版本号
    static var buildNumber: String? {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    /// App 当前版本号
    static var version: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    /// 设置状态栏颜色状态
    /// - Parameter style: 颜色状态
    static func configStatusBarStyle(style: UtilStatusBarStyle) {
        switch style {
        case .light:
            UIApplication.shared.statusBarStyle = .lightContent
        case .dark:
            if #available(iOS 13.0, *) {
                UIApplication.shared.statusBarStyle = .darkContent
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        }
    }
}
