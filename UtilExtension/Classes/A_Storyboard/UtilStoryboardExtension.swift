//
//  UtilStoryboardExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util == UIStoryboard {
    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        util.instantiateViewController(withIdentifier: String(describing: name)) as? T
    }
}
