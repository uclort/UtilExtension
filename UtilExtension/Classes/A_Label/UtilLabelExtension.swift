//
//  UtilLabelExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/25.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UILabel {
    static func create(
        frame: CGRect = .zero,
        text: String = "",
        font: UIFont = .systemFont(ofSize: 14),
        textColor: UIColor = UIColor.util.hex(0x333333),
        textAlignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }

    /// 获取文本行数
    /// - Parameters:
    ///   - maxWidth: 最大宽度
    ///   - useAttributedText: 是否使用属性文本计算
    ///     - 默认 false 不使用 true 的话直接用 UILabel().attributedText
    func lineNumber(
        maxWidth: CGFloat = -1,
        useAttributedText: Bool = false
    ) -> Int {
        var textString: NSAttributedString?
        if useAttributedText {
            textString = util.attributedText
        } else {
            if let text = util.text, let font = util.font {
                textString = NSAttributedString(string: text, attributes: [.font: font])
            } else {
                return 0
            }
        }
        guard let textString else { return 0 }
        let width = maxWidth > 0 ? maxWidth : util.bounds.size.width
        return textString.util.lineNumber(maxWidth: width)
    }
}
