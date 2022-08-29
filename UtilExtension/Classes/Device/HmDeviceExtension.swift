//
//  UIDeviceExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/7/26.
//

import Foundation

#if os(iOS)
import UIKit
public typealias UtilDevice = UIDevice
#endif

#if os(macOS)
public typealias UtilDevice = Host
#endif

private class BundleClass: NSObject {}

public extension HmUtils where Util == UtilDevice {
     /// 设备型号
    static var modelName: String {
        guard let bundleUrl = Bundle(for: BundleClass.classForCoder()).url(forResource: "UtilExtension", withExtension: "bundle"),
              let jsonUrl = Bundle(url: bundleUrl)?.url(forResource: "apple-device", withExtension: "json"),
              let jsonData = try? Data(contentsOf: jsonUrl),
              let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let content = jsonObject.util.object(for: "content")
        else {
            return model
        }
        return content.util.string(for: model) ?? model
    }

    static var model: String {
        #if os(iOS)
        getiOSIdentifier()
        #else
        getmacOSIdentifier()
        #endif
    }

    #if os(iOS)
    private static func getiOSIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    #endif

    #if os(macOS)
    private static func getmacOSIdentifier() -> String {
        let service = IOServiceGetMatchingService(kIOMasterPortDefault,
                                                  IOServiceMatching("IOPlatformExpertDevice"))
        var modelIdentifier: String?
        if let modelData = IORegistryEntryCreateCFProperty(service, "model" as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? Data {
            modelIdentifier = String(data: modelData, encoding: .utf8)?.trimmingCharacters(in: .controlCharacters)
        }

        IOObjectRelease(service)
        return modelIdentifier ?? ""
    }
    #endif
}
