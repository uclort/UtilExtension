//
//  UtilStackViewExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/24.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UIStackView {
    /// 批量添加子视图
    /// - Parameter views: <#views description#>
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            util.addArrangedSubview($0)
        }
    }

    /// 根据参数创建一个 StackView
    /// - Parameters:
    ///   - arrangedSubviews: 子视图
    ///   - axis: 布局方向
    ///   - spacing: 子视图间距
    ///   - alignment: 对齐方式
    ///   - distribution: ---
    static func create(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0.0,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }
}
