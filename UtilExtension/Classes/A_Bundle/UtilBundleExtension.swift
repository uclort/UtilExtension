//
//  UtilBundleExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/9/20.
//

import Foundation

public extension UclortExtensionVariableUtil where Util == Bundle {
    /// 生成 Bundle 资源库
    /// - Parameters:
    ///   - target: Bundle 所在模块下的对象
    ///   - otherModuleName: 模块名称 可选
    ///   - otherBundleName: 资源库名称 可选 优先级最高
    static func create(
        for target: NSObject? = nil,
        otherModuleName: String? = nil,
        otherBundleName: String? = nil
    ) -> Bundle? {
        var resourceBundle: Bundle?
        if let target = target,
           let moduleName = NSStringFromClass(target.classForCoder).components(separatedBy: ".").first
        {
            let targetBundle = Bundle(for: target.classForCoder)
            let targetBundlePath = targetBundle.resourcePath ?? ""
            let resultBundleName = otherBundleName ?? moduleName
            if let resultBundle = Bundle(path: "/\(targetBundlePath)/\(resultBundleName).bundle") {
                resourceBundle = resultBundle
            } else {
                resourceBundle = Bundle.main
            }
        } else {
            if let otherBundleName = otherBundleName {
                let mainBundle = Bundle.main
                let mainBundlePath = mainBundle.resourcePath ?? ""
                let staticFrameworkPath = "\(mainBundlePath)/\(otherBundleName).bundle"
                let unStaticFrameworkPath = "\(mainBundlePath)/Frameworks/\(otherModuleName ?? otherBundleName).framework/\(otherBundleName).bundle"
                if let resultBundle = Bundle(path: staticFrameworkPath) {
                    resourceBundle = resultBundle
                } else if let resultBundle = Bundle(path: unStaticFrameworkPath) {
                    resourceBundle = resultBundle
                } else {
                    resourceBundle = Bundle.main
                }
            } else {
                resourceBundle = Bundle.main
            }
        }
        return resourceBundle
    }

    /// 创建 Bundle
    /// - Parameters:
    ///   - target: Bundle 所在模块下的对象
    ///   - bundleName: 资源库名称 可选 优先级最高
    static func create(
        for target: NSObject,
        bundleName: String? = nil
    ) -> Bundle? {
        create(for: target, otherBundleName: bundleName)
    }

    /// 创建 Bundle
    /// - Parameters:
    ///   - moduleName: 模块名称
    ///   - bundleName: 资源库名称
    static func create(
        moduleName: String,
        bundleName: String
    ) -> Bundle? {
        create(otherModuleName: moduleName, otherBundleName: bundleName)
    }

    /// 创建 Bundle
    /// - Parameter moduleBundleName: 模块资源名称
    static func create(
        moduleBundleName: String
    ) -> Bundle? {
        create(otherModuleName: moduleBundleName, otherBundleName: moduleBundleName)
    }
}
