//
//  HmRectExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/8.
//

public extension HmUtils where Util == CGRect {
    var top: CGFloat {
        get {
            util.origin.y
        }
        set(newY) {
            util.origin.y = newY
        }
    }

    var left: CGFloat {
        get {
            util.origin.x
        }
        set(newX) {
            util.origin.x = newX
        }
    }

    var bottom: CGFloat {
        get {
            top + util.height
        }
        set(newBottom) {
            top = (newBottom - util.height)
        }
    }

    var right: CGFloat {
        get {
            left + util.width
        }
        set(newRight) {
            left = (newRight - util.width)
        }
    }

    var center: CGPoint {
        get {
            CGPoint(x: left + util.width * 0.5, y: top + util.height * 0.5)
        }
        set(newCenter) {
            util.origin = CGPoint(x: left + (newCenter.x - centerX), y: top + (newCenter.y - centerY))
        }
    }

    var centerX: CGFloat {
        get {
            center.x
        }
        set(newCenterX) {
            util.origin.x = left + (newCenterX - centerX)
        }
    }

    var centerY: CGFloat {
        get {
            center.y
        }
        set(newCenterY) {
            util.origin.x = top + (newCenterY - centerY)
        }
    }

    var middle: CGPoint {
        CGPoint(x: util.width * 0.5, y: util.height * 0.5)
    }

    var middleX: CGFloat {
        util.width * 0.5
    }

    var middleY: CGFloat {
        util.height * 0.5
    }
}
