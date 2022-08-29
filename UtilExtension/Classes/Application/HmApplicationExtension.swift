//
//  UIApplicationExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/7/26.
//

#if os(iOS)
import UIKit
public typealias UtilApplication = UIApplication
#endif

#if os(macOS)
import AppKit
public typealias UtilApplication = NSApplication
#endif

public extension HmUtils where Util == UtilApplication {
    #if os(iOS)
    var keyWindow: UIWindow? {
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
        return nil
    }
    #endif

    enum Environment {
        case debug
        case testFlight
        case appStore
    }

    var inferredEnvironment: Environment {
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

    var displayName: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    var buildNumber: String? {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    var version: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
