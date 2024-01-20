//
//  UtilImageViewExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/10.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UIImageView {
    /// SwifterSwift: Make image view blurry
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = util.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        util.addSubview(blurEffectView)
        util.clipsToBounds = true
    }
}
