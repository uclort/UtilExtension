//
//  UtilButtonExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/25.
//

import Foundation
import UIKit

/// 按钮状态透明度设置
private let buttonStatusAlpha = CGFloat(0.7)

public struct UtilButtonActionModel {
    public let target: Any
    public let action: Selector
    public let event: UIControl.Event

    public init(target: Any, action: Selector, event: UIControl.Event) {
        self.target = target
        self.action = action
        self.event = event
    }
}

public enum UtilButtonInsideLayoutType {
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
    /// 只有文字 左边缘对齐
    case onlyTextBestLeft
    /// 只有文字 右边缘对齐
    case onlyTextBestRight
    /// 只有图片 左边缘对齐
    case onlyImageBestLeft
    /// 只有图片 右边缘对齐
    case onlyImageBestRight
    /// 无
    case none
}

// MARK: Create
public extension UclortExtensionVariableUtil where Util: UIButton {
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
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    static func create(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleNormalColor: UIColor = UIColor.util.hex(0x363636),
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
        actionModel: UtilButtonActionModel? = nil
    ) -> UIButton {
        let button = UIButton()
        button.util.config(
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
            normalBackgroundImage: normalBackgroundImage,
            highlightedBackgroundImage: highlightedBackgroundImage,
            selectedBackgroundImage: selectedBackgroundImage,
            disableBackgroundImage: disableBackgroundImage,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
        return button
    }

    /// 创建一个带文字的 Button
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
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    static func createTitleType(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleNormalColor: UIColor = UIColor.util.hex(0x363636),
        titleHighlightedColor: UIColor? = nil,
        titleSelectedColor: UIColor? = nil,
        titleDisableColor: UIColor? = nil,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
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

    /// 创建一个普通标题按钮
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - title: 按钮标题
    ///   - titleFont: 按钮标题字体
    ///   - titleColor: 按钮标题颜色
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    static func createTitleButton(
        frame: CGRect = .zero,
        title: String,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleColor: UIColor = UIColor.util.hex(0x363636),
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) -> UIButton {
        create(
            frame: frame,
            normalTitle: title,
            titleFont: titleFont,
            titleNormalColor: titleColor,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }

    /// 创建一个带图片的 Button
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - normalImage: 按钮默认状态下图片
    ///   - highlightedImage: 按钮高亮状态下图片
    ///   - selectedImage: 按钮选择状态下图片
    ///   - disableImage: 按钮不可用状态下图片
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    static func createImageType(
        frame: CGRect = .zero,
        normalImage: UIImage? = nil,
        highlightedImage: UIImage? = nil,
        selectedImage: UIImage? = nil,
        disableImage: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
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

    /// 创建一个带图片的按钮
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - image: 按钮图片
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    static func createImageButton(
        frame: CGRect = .zero,
        image: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) -> UIButton {
        create(
            frame: frame,
            normalImage: image,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }

    /// 创建一个通用类型的 Button 同时带有图片和文字
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
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    static func createGeneralType(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleNormalColor: UIColor = UIColor.util.hex(0x363636),
        titleHighlightedColor: UIColor? = nil,
        titleSelectedColor: UIColor? = nil,
        titleDisableColor: UIColor? = nil,
        normalImage: UIImage? = nil,
        highlightedImage: UIImage? = nil,
        selectedImage: UIImage? = nil,
        disableImage: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
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

    /// 创建一个通用按钮
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - title: 按钮标题
    ///   - titleFont: 按钮标题字体
    ///   - titleColor: 按钮标题颜色
    ///   - image: 按钮图片
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    static func createGeneralButton(
        frame: CGRect = .zero,
        title: String,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleColor: UIColor = UIColor.util.hex(0x363636),
        image: UIImage?,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) -> UIButton {
        create(
            frame: frame,
            normalTitle: title,
            titleFont: titleFont,
            titleNormalColor: titleColor,
            normalImage: image,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }
}

// MARK: Config
public extension UclortExtensionVariableUtil where Util: UIButton {
    /// 配置 Button
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
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    func config(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleNormalColor: UIColor = UIColor.util.hex(0x363636),
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
        actionModel: UtilButtonActionModel? = nil
    ) {
        let button = util
        button.frame = frame
        button.adjustsImageWhenDisabled = false
        button.adjustsImageWhenHighlighted = false
        button.showsTouchWhenHighlighted = false
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
                button.setTitleColor(titleNormalColor.util.alpha(buttonStatusAlpha), for: .highlighted)
                button.setTitleColor(titleNormalColor.util.alpha(buttonStatusAlpha), for: [.selected, .highlighted])
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
                button.setTitleColor(titleNormalColor.util.alpha(buttonStatusAlpha), for: .disabled)
                button.setTitleColor(titleNormalColor.util.alpha(buttonStatusAlpha), for: [.selected, .disabled])
            } else {
                button.setTitleColor(titleNormalColor, for: .disabled)
                button.setTitleColor(titleNormalColor, for: [.selected, .disabled])
            }
        }
        if let titleSelectedColor = titleSelectedColor {
            button.setTitleColor(titleSelectedColor, for: .selected)
            if titleHighlightedColor == nil {
                if clickEffect {
                    button.setTitleColor(titleSelectedColor.util.alpha(buttonStatusAlpha), for: [.selected, .highlighted])
                } else {
                    button.setTitleColor(titleSelectedColor, for: [.selected, .highlighted])
                }
            }
            if titleDisableColor == nil {
                if clickEffect {
                    button.setTitleColor(titleSelectedColor.util.alpha(buttonStatusAlpha), for: [.selected, .disabled])
                } else {
                    button.setTitleColor(titleSelectedColor, for: [.selected, .disabled])
                }
            }
        }

        if let normalImage = normalImage {
            button.setImage(normalImage, for: .normal)
        }
        if let highlightedImage = highlightedImage {
            button.setImage(highlightedImage, for: .highlighted)
            button.setImage(highlightedImage, for: [.selected, .highlighted])
        } else if let normalImage = normalImage {
            if clickEffect, let highlightedImage = normalImage.util.alpha(buttonStatusAlpha) {
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
            if clickEffect, let disableImage = normalImage.util.alpha(buttonStatusAlpha) {
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
                    button.setImage(selectedImage.util.alpha(buttonStatusAlpha), for: [.selected, .highlighted])
                } else {
                    button.setImage(selectedImage, for: [.selected, .highlighted])
                }
            }
            if disableImage == nil {
                if clickEffect {
                    button.setImage(selectedImage.util.alpha(buttonStatusAlpha), for: [.selected, .disabled])
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
            if clickEffect, let highlightedBackgroundImage = normalBackgroundImage.util.alpha(buttonStatusAlpha) {
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
            if clickEffect, let disableBackgroundImage = normalBackgroundImage.util.alpha(buttonStatusAlpha) {
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
                    button.setBackgroundImage(selectedBackgroundImage.util.alpha(buttonStatusAlpha), for: [.selected, .highlighted])
                } else {
                    button.setBackgroundImage(selectedBackgroundImage, for: [.selected, .highlighted])
                }
            }
            if disableBackgroundImage == nil {
                if clickEffect {
                    button.setBackgroundImage(selectedBackgroundImage.util.alpha(buttonStatusAlpha), for: [.selected, .disabled])
                } else {
                    button.setBackgroundImage(selectedBackgroundImage, for: [.selected, .disabled])
                }
            }
        }
        if let actionModel = actionModel {
            button.addTarget(actionModel.target, action: actionModel.action, for: actionModel.event)
        }
    }

    /// 配置文字 Button
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
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    func configTitleType(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleNormalColor: UIColor = UIColor.util.hex(0x363636),
        titleHighlightedColor: UIColor? = nil,
        titleSelectedColor: UIColor? = nil,
        titleDisableColor: UIColor? = nil,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) {
        config(
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

    /// 创建一个普通标题按钮
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - title: 按钮标题
    ///   - titleFont: 按钮标题字体
    ///   - titleColor: 按钮标题颜色
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    func configTitleButton(
        frame: CGRect = .zero,
        title: String,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleColor: UIColor = UIColor.util.hex(0x363636),
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) {
        config(
            frame: frame,
            normalTitle: title,
            titleFont: titleFont,
            titleNormalColor: titleColor,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }

    /// 创建一个带图片的 Button
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - normalImage: 按钮默认状态下图片
    ///   - highlightedImage: 按钮高亮状态下图片
    ///   - selectedImage: 按钮选择状态下图片
    ///   - disableImage: 按钮不可用状态下图片
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    func configImageType(
        frame: CGRect = .zero,
        normalImage: UIImage? = nil,
        highlightedImage: UIImage? = nil,
        selectedImage: UIImage? = nil,
        disableImage: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) {
        config(
            frame: frame,
            normalImage: normalImage,
            highlightedImage: highlightedImage,
            selectedImage: selectedImage,
            disableImage: disableImage,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }

    /// 创建一个带图片的按钮
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - image: 按钮图片
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    func configImageButton(
        frame: CGRect = .zero,
        image: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) {
        config(
            frame: frame,
            normalImage: image,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }

    /// 创建一个通用类型的 Button 同时带有图片和文字
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
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    func configGeneralType(
        frame: CGRect = .zero,
        normalTitle: String = "",
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleNormalColor: UIColor = UIColor.util.hex(0x363636),
        titleHighlightedColor: UIColor? = nil,
        titleSelectedColor: UIColor? = nil,
        titleDisableColor: UIColor? = nil,
        normalImage: UIImage? = nil,
        highlightedImage: UIImage? = nil,
        selectedImage: UIImage? = nil,
        disableImage: UIImage? = nil,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) {
        config(
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

    /// 创建一个通用按钮
    /// - Parameters:
    ///   - frame: 按钮尺寸
    ///   - title: 按钮标题
    ///   - titleFont: 按钮标题字体
    ///   - titleColor: 按钮标题颜色
    ///   - image: 按钮图片
    ///   - clickEffect: 点击效果
    ///   - actionModel: 选择器对象模型
    /// - Returns: UIButton
    func configGeneralButton(
        frame: CGRect = .zero,
        title: String,
        titleFont: UIFont = .systemFont(ofSize: 16),
        titleColor: UIColor = UIColor.util.hex(0x363636),
        image: UIImage?,
        clickEffect: Bool = true,
        actionModel: UtilButtonActionModel? = nil
    ) {
        config(
            frame: frame,
            normalTitle: title,
            titleFont: titleFont,
            titleNormalColor: titleColor,
            normalImage: image,
            clickEffect: clickEffect,
            actionModel: actionModel
        )
    }
    
    /// 设置 Button 标题
    /// - Parameters:
    ///   - title: 按钮默认状态下标题
    ///   - highlightedTitle: 按钮高亮状态下文字
    ///   - selectedTitle: 按钮选择状态下文字
    ///   - disableTitle: 按钮不可用状态下文字
    func setTitle(
        title: String,
        highlightedTitle: String? = nil,
        selectedTitle: String? = nil,
        disableTitle: String? = nil
    ) {
        util.setTitle(title, for: .normal)
        if let highlightedTitle = highlightedTitle {
            util.setTitle(highlightedTitle, for: .highlighted)
            util.setTitle(highlightedTitle, for: [.selected, .highlighted])
        } else {
            util.setTitle(title, for: .highlighted)
            util.setTitle(title, for: [.selected, .highlighted])
        }
        if let disableTitle = disableTitle {
            util.setTitle(disableTitle, for: .disabled)
            util.setTitle(disableTitle, for: [.selected, .disabled])
        } else {
            util.setTitle(title, for: .disabled)
            util.setTitle(title, for: [.selected, .disabled])
        }
        if let selectedTitle = selectedTitle {
            util.setTitle(selectedTitle, for: .selected)
            if highlightedTitle == nil {
                util.setTitle(selectedTitle, for: [.selected, .highlighted])
            }
            if disableTitle == nil {
                util.setTitle(selectedTitle, for: [.selected, .disabled])
            }
        }
    }
    
    /// 设置 Button 富文本标题
    /// - Parameters:
    ///   - title: 按钮默认状态下富文本文字
    ///   - highlightedTitle: 按钮高亮状态下富文本文字
    ///   - selectedTitle: 按钮选择状态下富文本文字
    ///   - disableTitle: 按钮不可用状态下富文本文字
    func setAttributedTitle(
        title: NSAttributedString,
        highlightedTitle: NSAttributedString? = nil,
        selectedTitle: NSAttributedString? = nil,
        disableTitle: NSAttributedString? = nil
    ) {
        util.setAttributedTitle(title, for: .normal)
        if let highlightedTitle = highlightedTitle {
            util.setAttributedTitle(highlightedTitle, for: .highlighted)
            util.setAttributedTitle(highlightedTitle, for: [.selected, .highlighted])
        } else {
            util.setAttributedTitle(title, for: .highlighted)
            util.setAttributedTitle(title, for: [.selected, .highlighted])
        }
        if let disableTitle = disableTitle {
            util.setAttributedTitle(disableTitle, for: .disabled)
            util.setAttributedTitle(disableTitle, for: [.selected, .disabled])
        } else {
            util.setAttributedTitle(title, for: .disabled)
            util.setAttributedTitle(title, for: [.selected, .disabled])
        }
        if let selectedTitle = selectedTitle {
            util.setAttributedTitle(selectedTitle, for: .selected)
            if highlightedTitle == nil {
                util.setAttributedTitle(selectedTitle, for: [.selected, .highlighted])
            }
            if disableTitle == nil {
                util.setAttributedTitle(selectedTitle, for: [.selected, .disabled])
            }
        }
    }

    /// 设置按钮图片
    /// - Parameters:
    ///   - image: 默认图片
    ///   - highlightedImage: 按钮高亮状态下图片
    ///   - selectedImage: 按钮选择状态下图片
    ///   - disableImage: 按钮不可用状态下图片
    ///   - clickEffect: 点击效果
    func setImage(
        image: UIImage?,
        highlightedImage: UIImage? = nil,
        selectedImage: UIImage? = nil,
        disableImage: UIImage? = nil,
        clickEffect: Bool = true
    ) {
        util.setImage(image, for: .normal)
        if let highlightedImage = highlightedImage {
            util.setImage(highlightedImage, for: .highlighted)
            util.setImage(highlightedImage, for: [.selected, .highlighted])
        } else if let image = image {
            if clickEffect, let highlightedImage = image.util.alpha(buttonStatusAlpha) {
                util.setImage(highlightedImage, for: .highlighted)
                util.setImage(highlightedImage, for: [.selected, .highlighted])
            } else {
                util.setImage(image, for: .highlighted)
                util.setImage(image, for: [.selected, .highlighted])
            }
        }
        if let disableImage = disableImage {
            util.setImage(disableImage, for: .disabled)
            util.setImage(disableImage, for: [.selected, .disabled])
        } else if let image = image {
            if clickEffect, let disableImage = image.util.alpha(buttonStatusAlpha) {
                util.setImage(disableImage, for: .disabled)
                util.setImage(disableImage, for: [.selected, .disabled])
            } else {
                util.setImage(image, for: .disabled)
                util.setImage(image, for: [.selected, .disabled])
            }
        }
        if let selectedImage = selectedImage {
            util.setImage(selectedImage, for: .selected)
            if highlightedImage == nil {
                if clickEffect {
                    util.setImage(selectedImage.util.alpha(buttonStatusAlpha), for: [.selected, .highlighted])
                } else {
                    util.setImage(selectedImage, for: [.selected, .highlighted])
                }
            }
            if disableImage == nil {
                if clickEffect {
                    util.setImage(selectedImage.util.alpha(buttonStatusAlpha), for: [.selected, .disabled])
                } else {
                    util.setImage(selectedImage, for: [.selected, .disabled])
                }
            }
        }
    }

    /// 设置按钮背景图片
    /// - Parameters:
    ///   - image: 默认图片
    ///   - highlightedImage: 按钮高亮状态下图片
    ///   - selectedImage: 按钮选择状态下图片
    ///   - disableImage: 按钮不可用状态下图片
    ///   - clickEffect: 点击效果
    func setBackgroundImage(
        backgroundImage: UIImage?,
        highlightedBackgroundImage: UIImage? = nil,
        selectedBackgroundImage: UIImage? = nil,
        disableBackgroundImage: UIImage? = nil,
        clickEffect: Bool = true
    ) {
        util.setBackgroundImage(backgroundImage, for: .normal)
        if let highlightedBackgroundImage = highlightedBackgroundImage {
            util.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
            util.setBackgroundImage(highlightedBackgroundImage, for: [.selected, .highlighted])
        } else if let backgroundImage = backgroundImage {
            if clickEffect, let highlightedBackgroundImage = backgroundImage.util.alpha(buttonStatusAlpha) {
                util.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
                util.setBackgroundImage(highlightedBackgroundImage, for: [.selected, .highlighted])
            } else {
                util.setBackgroundImage(backgroundImage, for: .highlighted)
                util.setBackgroundImage(backgroundImage, for: [.selected, .highlighted])
            }
        }
        if let disableBackgroundImage = disableBackgroundImage {
            util.setBackgroundImage(disableBackgroundImage, for: .disabled)
            util.setBackgroundImage(disableBackgroundImage, for: [.selected, .disabled])
        } else if let backgroundImage = backgroundImage {
            if clickEffect, let disableBackgroundImage = backgroundImage.util.alpha(buttonStatusAlpha) {
                util.setBackgroundImage(disableBackgroundImage, for: .disabled)
                util.setBackgroundImage(disableBackgroundImage, for: [.selected, .disabled])
            } else {
                util.setBackgroundImage(backgroundImage, for: .disabled)
                util.setBackgroundImage(backgroundImage, for: [.selected, .disabled])
            }
        }
        if let selectedBackgroundImage = selectedBackgroundImage {
            util.setBackgroundImage(selectedBackgroundImage, for: .selected)
            if highlightedBackgroundImage == nil {
                if clickEffect {
                    util.setBackgroundImage(selectedBackgroundImage.util.alpha(buttonStatusAlpha), for: [.selected, .highlighted])
                } else {
                    util.setBackgroundImage(selectedBackgroundImage, for: [.selected, .highlighted])
                }
            }
            if disableBackgroundImage == nil {
                if clickEffect {
                    util.setBackgroundImage(selectedBackgroundImage.util.alpha(buttonStatusAlpha), for: [.selected, .disabled])
                } else {
                    util.setBackgroundImage(selectedBackgroundImage, for: [.selected, .disabled])
                }
            }
        }
    }
}

// MARK: Layout
public extension UclortExtensionVariableUtil where Util: UIButton {
    /// 设置内部布局类型
    /// - Parameters:
    ///   - style: 布局类型
    ///     - imageLeft or textRight: 图片在左 文字在右
    ///     - imageRight or textLeft: 图片在右 文字在左
    ///     - imageTop or textBottom: 图片在上 文字在下
    ///     - imageBottom or textTop: 图片在下 文字在上
    ///     - imageTextBestLeft: 图片 -> 文字 左边缘对齐按钮
    ///     - imageTextBestRight: 图片 -> 文字 右边缘对齐按钮
    ///     - textImageBestLeft: 文字 -> 图片 左边缘对齐按钮
    ///     - textImageBestRight: 文字 -> 图片 右边缘对齐按钮
    ///     - onlyTextBestLeft: 只有文字 左边缘对齐
    ///     - onlyTextBestRight: 只有文字 右边缘对齐
    ///     - onlyImageBestLeft: 只有图片 左边缘对齐
    ///     - onlyImageBestRight: 只有图片 右边缘对齐
    ///   - spacing: 图片和文字间距 only 系列无效
    func insideLayoutType(style: UtilButtonInsideLayoutType, spacing: CGFloat = 0) {
        let imageW = util.imageView?.image?.size.width ?? 0.0
        let titleW = util.titleLabel?.frame.size.width ?? 0.0
        // 文字和图片都不存在的情况下直接跳出
        if imageW + titleW == 0.0 { return }
        switch style {
        case .imageLeft, .textRight: // 默认 图片在左 文字在右
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -0.5 * spacing, bottom: 0.0, right: 0.5 * spacing)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.5 * spacing, bottom: 0.0, right: -0.5 * spacing)
        case .imageRight, .textLeft: // 图片在右 文字在左
            let imageOffset = titleW + 0.5 * spacing
            let titleOffset = imageW + 0.5 * spacing
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageOffset, bottom: 0.0, right: -imageOffset)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -titleOffset, bottom: 0.0, right: titleOffset)
        case .imageTop, .textBottom: // 图片在上 文字在下
            let imageH = util.imageView?.frame.size.height ?? 0.0
            let titleIntrinsicContentSizeW = util.titleLabel?.intrinsicContentSize.width ?? 0.0
            let titleIntrinsicContentSizeH = util.titleLabel?.intrinsicContentSize.height ?? 0.0
            util.imageEdgeInsets = UIEdgeInsets(top: -titleIntrinsicContentSizeH - spacing, left: 0.0, bottom: 0.0, right: -titleIntrinsicContentSizeW)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageW, bottom: -imageH - spacing, right: 0.0)
        case .imageBottom, .textTop: // 图片在下 文字在上
            let imageH = util.imageView?.frame.size.height ?? 0.0
            let titleIntrinsicContentSizeW = util.titleLabel?.intrinsicContentSize.width ?? 0.0
            let titleIntrinsicContentSizeH = util.titleLabel?.intrinsicContentSize.height ?? 0.0
            util.imageEdgeInsets = UIEdgeInsets(top: titleIntrinsicContentSizeH + spacing, left: 0.0, bottom: 0.0, right: -titleIntrinsicContentSizeW)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageW, bottom: imageH + spacing, right: 0.0)
        case .imageTextBestLeft: // 图片 -> 文字 左边缘对齐按钮
            let width = util.util.width
            var padding = width - (imageW + titleW)
            padding *= 0.5
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -padding, bottom: 0.0, right: padding)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -(padding - spacing), bottom: 0.0, right: padding - spacing)
        case .imageTextBestRight: // 图片 -> 文字 右边缘对齐按钮
            let width = util.util.width
            var padding = width - (imageW + titleW)
            padding *= 0.5
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: padding - spacing, bottom: 0.0, right: -(padding - spacing))
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: -padding)
        case .textImageBestLeft: // 文字 -> 图片 左边缘对齐按钮
            let width = util.util.width
            var padding = width - (imageW + titleW)
            padding *= 0.5
            let imageOffset = titleW - padding + spacing
            let titleOffset = imageW + padding
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageOffset, bottom: 0.0, right: -imageOffset)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -titleOffset, bottom: 0.0, right: titleOffset)
        case .textImageBestRight: // 文字 -> 图片 右边缘对齐按钮
            let width = util.util.width
            var padding = width - (imageW + titleW)
            padding *= 0.5
            let imageOffset = titleW + padding
            let titleOffset = imageW - padding + spacing
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageOffset, bottom: 0.0, right: -imageOffset)
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -titleOffset, bottom: 0.0, right: titleOffset)
        case .onlyTextBestLeft: // 只有文字 左边缘对齐
            let width = util.util.width
            var padding = width - titleW
            padding *= 0.5
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -padding, bottom: 0.0, right: padding)
        case .onlyTextBestRight: // 只有文字 右边缘对齐
            let width = util.util.width
            var padding = width - titleW
            padding *= 0.5
            util.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: -padding)
        case .onlyImageBestLeft: // 只有图片 左边缘对齐
            let width = util.util.width
            var padding = width - imageW
            padding *= 0.5
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -padding, bottom: 0.0, right: padding)
        case .onlyImageBestRight: // 只有图片 右边缘对齐
            let width = util.util.width
            var padding = width - imageW
            padding *= 0.5
            util.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: -padding)
        case .none:
            util.imageEdgeInsets = .zero
            util.titleEdgeInsets = .zero
        }
    }
}

private var ExtendEdgeInsetsKey: Void?

extension UIButton {
    /// 触摸响应范围扩展
    /// 分别对应上左下右
    public var utilTouchRangeEdgeInsets: UIEdgeInsets {
        get {
            return objc_getAssociatedObject(self, &ExtendEdgeInsetsKey) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
        set {
            objc_setAssociatedObject(self, &ExtendEdgeInsetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if utilTouchRangeEdgeInsets == .zero || !isEnabled || isHidden || alpha == 0.0 {
            return super.point(inside: point, with: event)
        }
        return extendRect(bounds).contains(point)
    }

    private func extendRect(_ rect: CGRect) -> CGRect {
        let x = rect.minX - utilTouchRangeEdgeInsets.left
        let y = rect.minY - utilTouchRangeEdgeInsets.top
        let w = rect.width + utilTouchRangeEdgeInsets.left + utilTouchRangeEdgeInsets.right
        let h = rect.height + utilTouchRangeEdgeInsets.top + utilTouchRangeEdgeInsets.bottom
        return CGRect(x: x, y: y, width: w, height: h)
    }
}
