//
//  HmViewExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

#if os(iOS)
import UIKit

public extension HmVariableUtils where Util: UIView {
    static var identifier: String {
        NSStringFromClass(Util.self)
    }
    
    /// 水平抗拉伸or压缩
    func setHorizontalTelescopicHigh() {
        util.setContentHuggingPriority(.required, for: .horizontal)
        util.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    /// 垂直抗拉伸
    func setVerticalTelescopicHigh() {
        util.setContentHuggingPriority(.required, for: .vertical)
        util.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    /// 转化为 UIImage
    func makeImageWithView(_ opaque: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(util.bounds.size, opaque, UIScreen.main.scale)
        util.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func removeAllSubview() {
        while util.subviews.count > 0 {
            util.subviews.last?.removeFromSuperview()
        }
    }
    func removeGestureRecognizers() {
        util.gestureRecognizers?.forEach(util.removeGestureRecognizer)
    }
    
    /// 控件尺寸
    var size: CGSize {
        get {
            util.frame.size
        }
        set(newSize) {
            util.frame.size = CGSize(width: newSize.width, height: newSize.height)
        }
    }
    
    /// 控件宽
    var width: CGFloat {
        get {
            util.frame.size.width
        }
        set(newWidth) {
            util.frame.size = CGSize(width: newWidth, height: height)
        }
    }
    
    /// 控件高
    var height: CGFloat {
        get {
            util.frame.size.height
        }
        set(newHeight) {
            util.frame.size = CGSize(width: width, height: newHeight)
        }
    }
    
    /// 控件左边距
    var left: CGFloat {
        get {
            util.frame.origin.x
        }
        set(newLeft) {
            util.frame = CGRect(x: newLeft, y: top, width: width, height: height)
        }
    }
    
    /// 控件右边距
    var right: CGFloat {
        get {
            left + width
        }
        set(newRight) {
            left = (newRight - width)
        }
    }
    
    /// 控件上边距
    var top: CGFloat {
        get {
            util.frame.origin.y
        }
        set(newTop) {
            util.frame = CGRect(x: left, y: newTop, width: width, height: height)
        }
    }
    
    /// 控件底边距
    var bottom: CGFloat {
        get {
            top + height
        }
        set(newBottom) {
            top = (newBottom - height)
        }
    }
    
    /// 控件相对父视图中心 X 轴
    var centerX: CGFloat {
        get {
            util.center.x
        }
        set(newCenterX) {
            util.center.x = newCenterX
        }
    }
    
    /// 控件相对父视图中心 Y 轴
    var centerY: CGFloat {
        get {
            util.center.y
        }
        set(newCenterY) {
            util.center.y = newCenterY
        }
    }
    
    /// 控件相对父视图坐标
    var origin: CGPoint {
        get {
            util.frame.origin
        }
        set(newOrigin) {
            util.frame.origin = newOrigin
        }
    }
    
    /// 控件自身坐标轴中心点
    var middle: CGPoint {
        CGPoint(x: width * 0.5, y: height * 0.5)
    }
    
    /// 控件自身坐标轴 X 轴
    var middleX: CGFloat {
        width * 0.5
    }
    
    /// 控件自身坐标轴 Y 轴
    var middleY: CGFloat {
        height * 0.5
    }
    
    /// 边线颜色
    var borderColor: UIColor? {
        get {
            guard let borderColor = util.layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            if let newValue = newValue {
                util.layer.borderColor = newValue.cgColor
            }
        }
    }
    
    /// 边线宽
    var borderWidth: CGFloat {
        get {
            util.layer.borderWidth
        }
        set {
            util.layer.borderWidth = newValue
        }
    }
    
    /// 圆角值
    var cornerRadius: CGFloat {
        get {
            util.layer.cornerRadius
        }
        set {
            util.layer.cornerRadius = newValue
        }
    }
    
    /// 阴影颜色
    var shadowColor: UIColor? {
        get {
            guard let shadowColor = util.layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: shadowColor)
        }
        set {
            if let newValue = newValue {
                util.layer.shadowColor = newValue.cgColor
            }
        }
    }
    
    /// 阴影透明度
    var shadowOpacity: Float {
        get {
            util.layer.shadowOpacity
        }
        set {
            util.layer.shadowOpacity = newValue
        }
    }
    
    /// 阴影偏移量
    var shadowOffset: CGSize {
        get {
            util.layer.shadowOffset
        }
        set {
            util.layer.shadowOffset = newValue
        }
    }
    
    /// 阴影半径
    var shadowRadius: CGFloat {
        get {
            util.layer.shadowRadius
        }
        set {
            util.layer.shadowRadius = newValue
        }
    }
    
    /// 创建一个外边框
    /// - Parameters:
    ///   - targetFrame: 外边框参照物的 frame
    ///   - borderWidth: 边框线尺寸
    ///   - borderColor: 边框线颜色
    ///   - layerName: 边框名称 创建之前会遍历所有的 layer 若发现相同 layer 会删除 防止多次叠加
    func addMarginBorder(targetFrame: CGRect, borderWidth: CGFloat, borderColor: UIColor, layerName: String? = nil) {
        if let layerName = layerName {
            util.layer.sublayers?.util.forEach(where: { $0.name == layerName }, body: { $0.removeFromSuperlayer() })
        }
        let layer = CALayer()
        layer.name = layerName
        layer.frame = .init(
            x: targetFrame.util.left - borderWidth,
            y: targetFrame.util.top - borderWidth,
            width: targetFrame.width + 2 * borderWidth,
            height: targetFrame.height + 2 * borderWidth
        )
        layer.masksToBounds = true
        layer.cornerRadius = util.util.cornerRadius + borderWidth
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        util.layer.addSublayer(layer)
    }
}
#endif
