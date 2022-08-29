//
//  HmButtonExtension.swift
//  Pods
//
//  Created by 侯猛 on 2022/8/25.
//

import Foundation

public struct HmUtilButtonActionModel {
    public let target: Any
    public let action: Selector
    public let event: UIControl.Event

    public init(target: Any, action: Selector, event: UIControl.Event) {
        self.target = target
        self.action = action
        self.event = event
    }
}

public enum HmUtilButtonInsideLayoutType {
    /// 默认 图片在左 文字在右
    case imageLeft
    case textRight
    /// 图片在右 文字在左
    case imageRight
    case textLeft
    /// 图片在上 文字在下
    case imageTop
    case textBottom
    /// 图片在下 文字在上
    case imageBottom
    case textTop
    /// 图片 -> 文字 左边缘对齐按钮
    case imageTextBestLeft
    /// 图片 -> 文字 右边缘对齐按钮
    case imageTextBestRight
    /// 文字 -> 图片 左边缘对齐按钮
    case textImageBestLeft
    /// 文字 -> 图片 右边缘对齐按钮
    case textImageBestRight
}

public extension HmVariableUtils where Util: UIButton {
    /// 创建一个 Button
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - normalTitle: 按钮默认状态下标题
    ///   - highlightedTitle: 按钮高亮状态下文字
    ///   - selectedTitle: 按钮选择状态下文字
    ///   - disableTitle: 按钮不可用状态下文字
    ///   - titleFont: 按钮标题字体
    ///   - titleNormalColor: 按钮默认状态下文字颜色
    ///   - titleHighlightedColor: 按钮高亮状态下文字颜色
    ///   - titleSelectedColor: 按钮选择状态下文字颜色
    ///   - titleDisableColor: 按钮不可用状态下文字颜色
    ///   - normalImage: 按钮默认状态下图片
    ///   - highlightedImage: 按钮高亮状态下图片
    ///   - selectedImage: 按钮选择状态下图片
    ///   - disableImage: 按钮不可用状态下图片
    ///   - normalBackgroupndImage: 按钮默认状态下背景图片
    ///   - highlightedBackgroundImage: 按钮高亮状态下背景图片
    ///   - selectedBackgroundImage: 按钮选择状态下背景图片
    ///   - disableBackGroundImage: 按钮不可用状态下背景图片
    ///   - clickEffect: 点击效果
    ///   - target: 选择器执行目标
    ///   - action: 选择器
    /// - Returns: UIButton
    static func create(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 14),
        titleNormalColor: UIColor = UIColor.util.hex(0x333333),
        titleHighlightedColor: UIColor? = nil,
        titleSelectedColor: UIColor? = nil,
        titleDisableColor: UIColor? = nil,
        normalImage: UIImage? = nil,
        highlightedImage: UIImage? = nil,
        selectedImage: UIImage? = nil,
        disableImage: UIImage? = nil,
        normalBackgroundImage: UIImage? = nil,
        highlightedBackgroundImage: UIImage? = nil,
        selectedBackgroundImage: UIImage? = nil,
        disableBackgroundImage: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: HmUtilButtonActionModel? = nil
    ) -> UIButton {
        let button = UIButton(frame: frame)

        button.setTitle(normalTitle, for: .normal)
        if let highlightedTitle = highlightedTitle {
            button.setTitle(highlightedTitle, for: .highlighted)
            button.setTitle(highlightedTitle, for: [.selected, .highlighted])
        } else {
            button.setTitle(normalTitle, for: .highlighted)
            button.setTitle(normalTitle, for: [.selected, .highlighted])
        }
        if let disableTitle = disableTitle {
            button.setTitle(disableTitle, for: .disabled)
            button.setTitle(disableTitle, for: [.selected, .disabled])
        } else {
            button.setTitle(normalTitle, for: .disabled)
            button.setTitle(normalTitle, for: [.selected, .disabled])
        }
        if let selectedTitle = selectedTitle {
            button.setTitle(selectedTitle, for: .selected)
            if highlightedTitle == nil {
                button.setTitle(selectedTitle, for: [.selected, .highlighted])
            }
            if disableTitle == nil {
                button.setTitle(selectedTitle, for: [.selected, .disabled])
            }
        }

        button.titleLabel?.font = titleFont

        button.setTitleColor(titleNormalColor, for: .normal)
        if let titleHighlightedColor = titleHighlightedColor {
            button.setTitleColor(titleHighlightedColor, for: .highlighted)
            button.setTitleColor(titleHighlightedColor, for: [.selected, .highlighted])
        } else {
            if clickEffect {
                button.setTitleColor(titleNormalColor.util.alpha(0.6), for: .highlighted)
                button.setTitleColor(titleNormalColor.util.alpha(0.6), for: [.selected, .highlighted])
            } else {
                button.setTitleColor(titleNormalColor, for: .highlighted)
                button.setTitleColor(titleNormalColor, for: [.selected, .highlighted])
            }
        }
        if let titleDisableColor = titleDisableColor {
            button.setTitleColor(titleDisableColor, for: .disabled)
            button.setTitleColor(titleDisableColor, for: [.selected, .disabled])
        } else {
            if clickEffect {
                button.setTitleColor(titleNormalColor.util.alpha(0.6), for: .disabled)
                button.setTitleColor(titleNormalColor.util.alpha(0.6), for: [.selected, .disabled])
            } else {
                button.setTitleColor(titleNormalColor, for: .disabled)
                button.setTitleColor(titleNormalColor, for: [.selected, .disabled])
            }
        }
        if let titleSelectedColor = titleSelectedColor {
            button.setTitleColor(titleSelectedColor, for: .selected)
            if titleHighlightedColor == nil {
                if clickEffect {
                    button.setTitleColor(titleSelectedColor.util.alpha(0.6), for: [.selected, .highlighted])
                } else {
                    button.setTitleColor(titleSelectedColor, for: [.selected, .highlighted])
                }
            }
            if titleDisableColor == nil {
                if clickEffect {
                    button.setTitleColor(titleSelectedColor.util.alpha(0.6), for: [.selected, .disabled])
                } else {
                    button.setTitleColor(titleSelectedColor, for: [.selected, .disabled])
                }
            }
        }

        if let normalImage = normalImage {
            button.setImage(normalImage, for: .normal)
            button.setImage(normalImage, for: .highlighted)
        }
        if let highlightedImage = highlightedImage {
            button.setImage(highlightedImage, for: .highlighted)
            button.setImage(highlightedImage, for: [.selected, .highlighted])
        } else if let normalImage = normalImage {
            if clickEffect, let highlightedImage = normalImage.util.alpha(0.6) {
                button.setImage(highlightedImage, for: .highlighted)
                button.setImage(highlightedImage, for: [.selected, .highlighted])
            } else {
                button.setImage(normalImage, for: .highlighted)
                button.setImage(normalImage, for: [.selected, .highlighted])
            }
        }
        if let disableImage = disableImage {
            button.setImage(disableImage, for: .disabled)
            button.setImage(disableImage, for: [.selected, .disabled])
        } else if let normalImage = normalImage {
            if clickEffect, let disableImage = normalImage.util.alpha(0.6) {
                button.setImage(disableImage, for: .disabled)
                button.setImage(disableImage, for: [.selected, .disabled])
            } else {
                button.setImage(normalImage, for: .disabled)
                button.setImage(normalImage, for: [.selected, .disabled])
            }
        }
        if let selectedImage = selectedImage {
            button.setImage(selectedImage, for: .selected)
            if highlightedImage == nil {
                if clickEffect {
                    button.setImage(selectedImage.util.alpha(0.6), for: [.selected, .highlighted])
                } else {
                    button.setImage(selectedImage, for: [.selected, .highlighted])
                }
            }
            if disableImage == nil {
                if clickEffect {
                    button.setImage(selectedImage.util.alpha(0.6), for: [.selected, .disabled])
                } else {
                    button.setImage(selectedImage, for: [.selected, .disabled])
                }
            }
        }

        if let normalBackgroundImage = normalBackgroundImage {
            button.setBackgroundImage(normalBackgroundImage, for: .normal)
        }
        if let highlightedBackgroundImage = highlightedBackgroundImage {
            button.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
            button.setBackgroundImage(highlightedBackgroundImage, for: [.selected, .highlighted])
        } else if let normalBackgroundImage = normalBackgroundImage {
            if clickEffect, let highlightedBackgroundImage = normalBackgroundImage.util.alpha(0.6) {
                button.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
                button.setBackgroundImage(highlightedBackgroundImage, for: [.selected, .highlighted])
            } else {
                button.setBackgroundImage(normalBackgroundImage, for: .highlighted)
                button.setBackgroundImage(normalBackgroundImage, for: [.selected, .highlighted])
            }
        }
        if let disableBackgroundImage = disableBackgroundImage {
            button.setBackgroundImage(disableBackgroundImage, for: .disabled)
            button.setBackgroundImage(disableBackgroundImage, for: [.selected, .disabled])
        } else if let normalBackgroundImage = normalBackgroundImage {
            if clickEffect, let disableBackgroundImage = normalBackgroundImage.util.alpha(0.6) {
                button.setBackgroundImage(disableBackgroundImage, for: .disabled)
                button.setBackgroundImage(disableBackgroundImage, for: [.selected, .disabled])
            } else {
                button.setBackgroundImage(normalBackgroundImage, for: .disabled)
                button.setBackgroundImage(normalBackgroundImage, for: [.selected, .disabled])
            }
        }
        if let selectedBackgroundImage = selectedBackgroundImage {
            button.setBackgroundImage(selectedBackgroundImage, for: .selected)
            if highlightedBackgroundImage == nil {
                if clickEffect {
                    button.setBackgroundImage(selectedBackgroundImage.util.alpha(0.6), for: [.selected, .highlighted])
                } else {
                    button.setBackgroundImage(selectedBackgroundImage, for: [.selected, .highlighted])
                }
            }
            if disableBackgroundImage == nil {
                if clickEffect {
                    button.setBackgroundImage(selectedBackgroundImage.util.alpha(0.6), for: [.selected, .disabled])
                } else {
                    button.setBackgroundImage(selectedBackgroundImage, for: [.selected, .disabled])
                }
            }
        }
        if let actionModel = actionModel {
            button.addTarget(actionModel.target, action: actionModel.action, for: actionModel.event)
        }
        return button
    }

    static func createTitleType(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 14),
        titleNormalColor: UIColor = UIColor.util.hex(0x333333),
        titleHighlightedColor: UIColor? = nil,
        titleSelectedColor: UIColor? = nil,
        titleDisableColor: UIColor? = nil,
        clickEffect: Bool = true,
        actionModel: HmUtilButtonActionModel? = nil
    ) -> UIButton {
        create(
            frame: frame,
            normalTitle: normalTitle,
            highlightedTitle: highlightedTitle,
            selectedTitle: selectedTitle,
            disableTitle: disableTitle,
            titleFont: titleFont,
            titleNormalColor: titleNormalColor,
            titleHighlightedColor: titleHighlightedColor,
            titleSelectedColor: titleSelectedColor,
            titleDisableColor: titleDisableColor,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }

    static func createImageType(
        frame: CGRect = .zero,
        normalImage: UIImage? = nil,
        highlightedImage: UIImage? = nil,
        selectedImage: UIImage? = nil,
        disableImage: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: HmUtilButtonActionModel? = nil
    ) -> UIButton {
        create(
            frame: frame,
            normalImage: normalImage,
            highlightedImage: highlightedImage,
            selectedImage: selectedImage,
            disableImage: disableImage,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }

    static func createGeneralType(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 14),
        titleNormalColor: UIColor = UIColor.util.hex(0x333333),
        titleHighlightedColor: UIColor? = nil,
        titleSelectedColor: UIColor? = nil,
        titleDisableColor: UIColor? = nil,
        normalImage: UIImage? = nil,
        highlightedImage: UIImage? = nil,
        selectedImage: UIImage? = nil,
        disableImage: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: HmUtilButtonActionModel? = nil
    ) -> UIButton {
        create(
            frame: frame,
            normalTitle: normalTitle,
            highlightedTitle: highlightedTitle,
            selectedTitle: selectedTitle,
            disableTitle: disableTitle,
            titleFont: titleFont,
            titleNormalColor: titleNormalColor,
            titleHighlightedColor: titleHighlightedColor,
            titleSelectedColor: titleSelectedColor,
            titleDisableColor: titleDisableColor,
            normalImage: normalImage,
            highlightedImage: highlightedImage,
            selectedImage: selectedImage,
            disableImage: disableImage,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }

    /// 设置内部布局类型
    /// - Parameters:
    ///   - style: 布局类型
    ///     - imageLeft or textRight: 图片在左 文字在右
    ///     - imageRight or textLeft: 图片在右 文字在左
    ///     - imageTop or textBottom: 图片在上 文字在下
    ///     - imageBottom or textTop: 图片在下 文字在上
    ///   - spacing: spacing description
    func insideLayoutType(style: HmUtilButtonInsideLayoutType, spacing: CGFloat) {
        switch style {
        case .imageLeft, .textRight: // 默认 图片左 文字右
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -0.5 * spacing, bottom: 0.0, right: 0.5 * spacing)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.5 * spacing, bottom: 0.0, right: -0.5 * spacing)
        case .imageRight, .textLeft:
            let imageW = util.imageView?.image?.size.width ?? 0.0
            let titleW = util.titleLabel?.frame.size.width ?? 0.0
            let imageOffset = titleW + 0.5 * spacing
            let titleOffset = imageW + 0.5 * spacing
            util.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageOffset, bottom: 0, right: -imageOffset)
            util.titleEdgeInsets = UIEdgeInsets(top: 0, left: -titleOffset, bottom: 0, right: titleOffset)
        case .imageTop, .textBottom:
            let imageW = util.imageView?.frame.size.width ?? 0.0
            let imageH = util.imageView?.frame.size.height ?? 0.0
            let titleIntrinsicContentSizeW = util.titleLabel?.intrinsicContentSize.width ?? 0.0
            let titleIntrinsicContentSizeH = util.titleLabel?.intrinsicContentSize.height ?? 0.0
            util.imageEdgeInsets = UIEdgeInsets(top: -titleIntrinsicContentSizeH - spacing, left: 0.0, bottom: 0.0, right: -titleIntrinsicContentSizeW)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageW, bottom: -imageH - spacing, right: 0.0)
        case .imageBottom, .textTop:
            let imageW = util.imageView?.frame.size.width ?? 0.0
            let imageH = util.imageView?.frame.size.height ?? 0.0
            let titleIntrinsicContentSizeW = util.titleLabel?.intrinsicContentSize.width ?? 0.0
            let titleIntrinsicContentSizeH = util.titleLabel?.intrinsicContentSize.height ?? 0.0
            util.imageEdgeInsets = UIEdgeInsets(top: titleIntrinsicContentSizeH + spacing, left: 0.0, bottom: 0.0, right: -titleIntrinsicContentSizeW)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageW, bottom: imageH + spacing, right: 0.0)
        case .imageTextBestLeft: // 图片 -> 文字 左边缘对齐按钮
            let width = util.util.width
            let imageW = util.imageView?.image?.size.width ?? 0.0
            let titleW = util.titleLabel?.frame.size.width ?? 0.0
            var padding = width - (imageW + titleW)
            padding *= 0.5
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -padding, bottom: 0.0, right: padding)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -(padding - spacing), bottom: 0.0, right: padding - spacing)
        case .imageTextBestRight: // 图片 -> 文字 右边缘对齐按钮
            let width = util.util.width
            let imageW = util.imageView?.image?.size.width ?? 0.0
            let titleW = util.titleLabel?.frame.size.width ?? 0.0
            var padding = width - (imageW + titleW)
            padding *= 0.5
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: padding - spacing, bottom: 0.0, right: -(padding - spacing))
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: -padding)
        case .textImageBestLeft: // 文字 -> 图片 左边缘对齐按钮
            let width = util.util.width
            let imageW = util.imageView?.image?.size.width ?? 0.0
            let titleW = util.titleLabel?.frame.size.width ?? 0.0
            var padding = width - (imageW + titleW)
            padding *= 0.5
            let imageOffset = titleW - padding + spacing
            let titleOffset = imageW + padding
            util.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageOffset, bottom: 0, right: -imageOffset)
            util.titleEdgeInsets = UIEdgeInsets(top: 0, left: -titleOffset, bottom: 0, right: titleOffset)
        case .textImageBestRight: // 文字 -> 图片 右边缘对齐按钮
            let width = util.util.width
            let imageW = util.imageView?.image?.size.width ?? 0.0
            let titleW = util.titleLabel?.frame.size.width ?? 0.0
            var padding = width - (imageW + titleW)
            padding *= 0.5
            let imageOffset = titleW + padding
            let titleOffset = imageW - padding + spacing
            util.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageOffset, bottom: 0, right: -imageOffset)
            util.titleEdgeInsets = UIEdgeInsets(top: 0, left: -titleOffset, bottom: 0, right: titleOffset)
        }
    }
}
