//
//  UtilExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import UIKit

public extension UclortExtensionVariableUtil where Util: UIView {
    /// 设置是否展示 !hidden
    var isShow: Bool {
        get {
            !util.isHidden
        }
        set {
            util.isHidden = !newValue
        }
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

    /// 转成 UIImage
    /// - Parameter opaque: 指示位图是否不透明的布尔标志。如果您知道位图完全不透明，请指定 true 忽略 Alpha 通道并优化位图的存储。指定 false 意味着位图必须包含一个 alpha 通道来处理任何部分透明的像素。
    func makeImageWithView(_ opaque: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(util.bounds.size, opaque, UIScreen.util.scale)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        util.layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
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

    /// 删除所有子视图
    func removeAllSubview() {
        while util.subviews.count > 0 {
            util.subviews.last?.removeFromSuperview()
        }
    }

    /// 删除所有手势
    func removeGestureRecognizers() {
        util.gestureRecognizers?.forEach(util.removeGestureRecognizer)
    }

    /// 存在的视图控制器
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = util
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    /// 绘制圆角
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: util.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        util.layer.mask = shape
    }

    /// 添加阴影
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        util.layer.shadowColor = color.cgColor
        util.layer.shadowOffset = offset
        util.layer.shadowRadius = radius
        util.layer.shadowOpacity = opacity
        util.layer.masksToBounds = false
    }

    /// 绘制水平虚线
    /// - Parameters:
    ///   - lineColor: 虚线颜色
    ///   - lineWidth: 虚线宽度
    ///   - lineHeight: 虚线高度
    ///   - gapLength: 虚线间隔
    ///   - layerName: 虚线名称
    func addHorizontalDottedLineLayer(
        lineColor: UIColor,
        lineWidth: CGFloat = 7.0,
        lineHeight: CGFloat = 1.0,
        gapLength: CGFloat = 2.0,
        layerName: String = "dottedLineLayer_horizontal"
    ) {
        addDottedLineLayer(
            lineColor: lineColor,
            lineSize: lineHeight,
            lineLength: lineWidth,
            gapLength: gapLength,
            layerName: layerName
        )
    }

    /// 绘制垂直虚线
    /// - Parameters:
    ///   - lineColor: 虚线颜色
    ///   - lineWidth: 虚线宽度
    ///   - lineHeight: 虚线高度
    ///   - gapLength: 虚线间隔
    ///   - layerName: 虚线名称
    func addVerticalDottedLineLayer(
        lineColor: UIColor,
        lineWidth: CGFloat = 7.0,
        lineHeight: CGFloat = 1.0,
        gapLength: CGFloat = 2.0,
        layerName: String = "dottedLineLayer_vertical"
    ) {
        addDottedLineLayer(
            lineColor: lineColor,
            lineSize: lineWidth,
            lineLength: lineHeight,
            gapLength: gapLength,
            vertical: true,
            layerName: layerName
        )
    }

    /// 绘制虚线
    /// - Parameters:
    ///   - lineColor: 虚线颜色
    ///   - lineSize: 虚线尺寸
    ///   - lineLength: 虚线长度
    ///   - gapLength: 虚线间隔
    ///   - vertical: 是否垂直
    ///   - layerName: 虚线名称
    private func addDottedLineLayer(
        lineColor: UIColor,
        lineSize: CGFloat,
        lineLength: CGFloat,
        gapLength: CGFloat,
        vertical: Bool = false,
        layerName: String
    ) {
        let size = util.util.size
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = util.bounds
        shapeLayer.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor

        shapeLayer.lineWidth = lineSize
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        // 每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: gapLength)]

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        if vertical { // 纵向
            path.addLine(to: CGPoint(x: 0, y: size.height))
        } else {
            path.addLine(to: CGPoint(x: size.width, y: 0))
        }
        shapeLayer.path = path
        util.util.addSublayer(layer: shapeLayer, name: layerName, deleteSameNameLayer: true)
    }

    /// 添加外边框
    /// - Parameters:
    ///   - frame: 需要绘制外边框的目标位置和大小
    ///   - borderWidth: 边框尺寸
    ///   - borderColor: 边框颜色
    ///   - layerName: 边框名称
    func addOuterBorderLayer(
        frame: CGRect,
        borderWidth: CGFloat,
        borderColor: UIColor,
        layerName: String? = nil
    ) {
        let layer = CALayer()
        layer.name = layerName
        layer.frame = .init(
            x: frame.minX - borderWidth,
            y: frame.minY - borderWidth,
            width: frame.width + 2 * borderWidth,
            height: frame.height + 2 * borderWidth
        )
        layer.masksToBounds = true
        layer.cornerRadius = util.util.cornerRadius + borderWidth
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        addSublayer(layer: layer, name: layerName, deleteSameNameLayer: true)
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach {
            util.addSubview($0)
        }
    }

    /// 添加子 layer
    /// - Parameters:
    ///   - layer: 目标
    ///   - name: layer 名称
    ///   - deleteSameNameLayer: 是否删除同名图层
    ///       - 默认不删除
    func addSublayer(
        layer: CALayer,
        name: String? = nil,
        deleteSameNameLayer: Bool = false
    ) {
        if deleteSameNameLayer {
            removeLayer(for: name)
        }
        layer.name = name ?? layer.name
        util.layer.addSublayer(layer)
    }

    /// 插入子 layer
    /// - Parameters:
    ///   - layer: 目标
    ///   - index: 插入的位置
    ///   - name: layer 名称
    ///   - deleteSameNameLayer: 是否删除同名图层
    ///       - 默认不删除
    func insertSublayer(
        layer: CALayer,
        at index: UInt,
        name: String? = nil,
        deleteSameNameLayer: Bool = false
    ) {
        if deleteSameNameLayer {
            removeLayer(for: name)
        }
        layer.name = name ?? layer.name
        util.layer.insertSublayer(layer, at: UInt32(index))
    }

    /// 删除子 layer
    /// - Parameter name: 需要删除的 layer 名称
    func removeLayer(for name: String?) {
        guard let name else { return }
        util.layer.sublayers?.first(where: { $0.name == name })?.removeFromSuperlayer()
    }

    /// 创建渐变背景色 layer
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: layer 尺寸 非必传
    ///       - 不传或者传 .zero 则使用 view.bounds.size
    ///   - radius: 图片圆角 非必传
    ///       - 默认值 0 不设置圆角
    ///   - opacity: 不透明度
    ///       - 默认值 1 不透明
    ///   - locations: locations 数组 非必传
    ///       - 必须和 colors 数量保持一致
    ///       - 每个 location 对应每个颜色的渐变起始点
    ///       - 意义不清楚可以不传或者传 nil
    ///   - direction: 渐变的方向
    ///       - 默认水平
    ///   - insertIndex: 插入的位置
    ///       - 默认 -1 不插入 直接 addSublayer
    ///       - 传入 0 或者正整数则使用 insertSublayer 方式
    ///   - name: layer 名称 非必传
    ///       - 用作删除查找
    static func createGradientLayer(
        for colors: [UIColor],
        size: CGSize,
        radius: CGFloat = 0.0,
        opacity: CGFloat = 1.0,
        locations: [Double]? = nil,
        direction: PKGradientDirection = .horizontal,
        name: String? = nil
    ) -> CALayer {
        var locationsGroup: [Double] = []
        if let locations {
            locationsGroup = locations
        } else {
            let locationIncrementalValue = 1.0 / Double(colors.count - 1)
            for index in 0 ..< colors.count {
                locationsGroup.append(Double(index) * locationIncrementalValue)
            }
            locationsGroup.removeLast()
            locationsGroup.append(1.0)
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = radius
        gradientLayer.frame = .init(origin: .zero, size: size)
        gradientLayer.colors = colors.map { $0.cgColor }
        let pointTuple = direction.viewPoint(size: size)
        gradientLayer.startPoint = pointTuple.startPoint
        gradientLayer.endPoint = pointTuple.endPoint
        gradientLayer.locations = locationsGroup.map { NSNumber(value: $0) }
        gradientLayer.opacity = Float(opacity)
        gradientLayer.name = name
        return gradientLayer
    }

    /// 添加渐变背景色 layer
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: layer 尺寸 非必传
    ///       - 不传或者传 .zero 则使用 view.bounds.size
    ///   - radius: 图片圆角 非必传
    ///       - 默认值 0 不设置圆角
    ///   - opacity: 不透明度
    ///       - 默认值 1 不透明
    ///   - locations: locations 数组 非必传
    ///       - 必须和 colors 数量保持一致
    ///       - 每个 location 对应每个颜色的渐变起始点
    ///       - 意义不清楚可以不传或者传 nil
    ///   - direction: 渐变的方向
    ///       - 默认水平
    ///   - insertIndex: 插入的位置
    ///       - 默认 -1 不插入 直接 addSublayer
    ///       - 传入 0 或者正整数则使用 insertSublayer 方式
    ///   - name: layer 名称 非必传
    ///       - 用作删除查找
    ///   - deleteSameNameLayer: 是否删除同名图层
    ///       - 默认不删除
    @discardableResult
    func addGradientLayer(
        for colors: [UIColor],
        size: CGSize = .zero,
        radius: CGFloat = 0,
        opacity: CGFloat = 1.0,
        locations: [Double]? = nil,
        direction: PKGradientDirection = .horizontal,
        name: String? = nil,
        deleteSameNameLayer: Bool = false
    ) -> CALayer {
        let size = size == .zero ? util.bounds.size : size
        let gradientLayer = UIView.util.createGradientLayer(for: colors, size: size, radius: radius, opacity: opacity, locations: locations, direction: direction, name: name)
        addSublayer(layer: gradientLayer, deleteSameNameLayer: deleteSameNameLayer)
        return gradientLayer
    }

    /// 添加渐变背景色 layer
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: layer 尺寸 非必传
    ///       - 不传或者传 .zero 则使用 view.bounds.size
    ///   - radius: 图片圆角 非必传
    ///       - 默认值 0 不设置圆角
    ///   - opacity: 不透明度
    ///       - 默认值 1 不透明
    ///   - locations: locations 数组 非必传
    ///       - 必须和 colors 数量保持一致
    ///       - 每个 location 对应每个颜色的渐变起始点
    ///       - 意义不清楚可以不传或者传 nil
    ///   - direction: 渐变的方向
    ///       - 默认水平
    ///   - name: layer 名称 非必传
    ///       - 用作删除查找
    ///   - deleteSameNameLayer: 是否删除同名图层
    ///       - 默认不删除
    ///   - index: 插入的位置
    @discardableResult
    func insertGradientLayer(
        for colors: [UIColor],
        size: CGSize = .zero,
        radius: CGFloat = 0,
        opacity: CGFloat = 1.0,
        locations: [Double]? = nil,
        direction: PKGradientDirection = .horizontal,
        name: String? = nil,
        deleteSameNameLayer: Bool = false,
        at index: UInt
    ) -> CALayer {
        let size = size == .zero ? util.bounds.size : size
        let gradientLayer = UIView.util.createGradientLayer(for: colors, size: size, radius: radius, opacity: opacity, locations: locations, direction: direction, name: name)
        insertSublayer(layer: gradientLayer, at: index, deleteSameNameLayer: deleteSameNameLayer)
        return gradientLayer
    }
}

// MARK: Static
public extension UclortExtensionVariableUtil where Util: UIView {
    /// Load view from nib.
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    static func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    /// 标识符
    static var identifier: String {
        String(describing: Util.self)
    }
}

open class NiblessView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable, message: "Instantiating this view from a nib is not supported.")
    public required init?(coder _: NSCoder) {
        fatalError("Instantiating this view from a nib is not supported.")
    }
}

// MARK: 动画
public extension UclortExtensionVariableUtil where Util: UIView {
    /// 执行自旋转动画
    /// - Parameters:
    ///   - duration: 单次动画执行时间
    ///   - cover: 覆盖添加动画
    ///     - 默认 false 如果动画正在执行则退出
    func startRotateAnimation(duration: CFTimeInterval = 1.0, cover: Bool = false) {
        // 判断如果当前视图已经在执行旋转
        // 并且 cover false 为不覆盖添加
        // 则直接 return 防止动画顿挫
        if let _ = util.layer.animation(forKey: "RotateAnimation_Extension"), cover == false {
            return
        }
        let rotationAnimatioin = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimatioin.toValue = Double.pi * 2.0
        rotationAnimatioin.duration = duration
        rotationAnimatioin.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        rotationAnimatioin.isRemovedOnCompletion = false
        util.layer.add(rotationAnimatioin, forKey: "RotateAnimation_Extension")
    }

    /// 停止自旋转动画
    func stopRotateAnimation() {
        util.layer.removeAnimation(forKey: "RotateAnimation_Extension")
    }
}
