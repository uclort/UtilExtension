//
//  UtilEdgeInsetsExtension.swift
//  AFNetworking
//
//  Created by 侯猛 on 2022/8/8.
//

import Foundation

public extension UclortExtensionUtil where Util == UIEdgeInsets {
    /// SwifterSwift: Creates an `EdgeInsets` with the inset value applied to all (top, bottom, right, left)
    ///
    /// - Parameter inset: Inset to be applied in all the edges.
    static func create(inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// SwifterSwift: Creates an `EdgeInsets` with the horizontal value equally divided and applied to right and left.
    ///               And the vertical value equally divided and applied to top and bottom.
    ///
    ///
    /// - Parameter horizontal: Inset to be applied to right and left.
    /// - Parameter vertical: Inset to be applied to top and bottom.
    static func create(horizontal: CGFloat, vertical: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: vertical / 2.0, left: horizontal / 2.0, bottom: vertical / 2.0, right: horizontal / 2.0)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and top offset.
    ///
    /// - Parameters:
    ///   - top: Offset to be applied in to the top edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(top: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: util.top + top, left: util.left, bottom: util.bottom, right: util.right)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and left offset.
    ///
    /// - Parameters:
    ///   - left: Offset to be applied in to the left edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(left: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: util.top, left: util.left + left, bottom: util.bottom, right: util.right)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameters:
    ///   - bottom: Offset to be applied in to the bottom edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(bottom: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: util.top, left: util.left, bottom: util.bottom + bottom, right: util.right)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and right offset.
    ///
    /// - Parameters:
    ///   - right: Offset to be applied in to the right edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(right: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: util.top, left: util.left, bottom: util.bottom, right: util.right + right)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and horizontal value equally divided and applied to right offset and left offset.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to right and left.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(horizontal: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: util.top, left: util.left + horizontal / 2.0, bottom: util.bottom, right: util.right + horizontal / 2.0)
    }

    /// SwifterSwift: Creates an `EdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - vertical: Offset to be applied to top and bottom.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(vertical: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: util.top + vertical / 2.0, left: util.left, bottom: util.bottom + vertical / 2.0, right: util.right)
    }

    /// SwifterSwift: Return the vertical insets. The vertical insets is composed by top + bottom.
    ///
    var vertical: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/SwifterSwift/EdgeInsets%2BExtensions.swift
        return util.top + util.bottom
    }

    /// SwifterSwift: Return the horizontal insets. The horizontal insets is composed by  left + right.
    ///
    var horizontal: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/SwifterSwift/EdgeInsets%2BExtensions.swift
        return util.left + util.right
    }
}
