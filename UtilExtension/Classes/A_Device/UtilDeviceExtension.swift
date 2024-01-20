//
//  UtilDeviceExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/24.
//

import Foundation

public enum DeviceType {
    case pad
    case phone
    case tv
    case mac
    case carPlay
    case unknow
}

public extension UclortExtensionVariableUtil where Util == UIDevice {
    /// 是否为全面屏手机
    static var isFullScreen: Bool {
        UIScreen.util.safeBottomHeight > 0
    }

    /// 当前设备
    static var deviceType: DeviceType {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return .phone
        case .pad:
            return .pad
        case .tv:
            return .tv
        case .carPlay:
            return .carPlay
        case .mac:
            return .mac
        default:
            return .unknow
        }
    }

    /// 设备具体型号
    static var modelName: String {
        guard let bundleUrl = Bundle.util.create(for: nil, otherModuleName: "UtilExtension", otherBundleName: "UtilExtensionResources")?.bundleURL,
              let jsonUrl = Bundle(url: bundleUrl)?.url(forResource: "apple-device", withExtension: "json"),
              let jsonData = try? Data(contentsOf: jsonUrl),
              let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let content = jsonObject.util.object(for: "content")
        else {
            return model
        }
        return content.util.string(for: model) ?? model
    }

    /// 设备标识
    static var model: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
