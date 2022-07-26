//
//  HmArrayExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

public extension HmArrayUtils where Util: Sequence {
    struct HmValue {
        var value: Util.Iterator.Element
        var index: Int
        var isFirst: Bool
        var isLast: Bool
        var stop: (Bool) -> Void
    }
    
    func forEach(_ body: (_ value: HmValue) -> Void) {
        for (idx, item) in util.enumerated() {
            var isStop: Bool = false
            let value = HmValue(
                value: item,
                index: idx,
                isFirst: idx == 0,
                isLast: idx == lastIndex) { stop in
                    isStop = stop
                }
            body(value)
            if isStop {
                return
            }
        }
    }
    
    var lastIndex: Int {
        guard let element = util as? [Util.Iterator.Element] else { return 0 }
        guard element.count > 0 else {
            return 0
        }
        return element.count - 1
    }
    
    func objectFrom(index: Int) -> Util.Iterator.Element? {
        guard let element = util as? [Util.Iterator.Element] else { return nil }
        guard case 0 ..< element.count = index else {
            return nil
        }
        return element[index]
    }
    
    func forEach(where condition: (Util.Iterator.Element) -> Bool, body: (Util.Iterator.Element) -> Void) {
        for element in util where condition(element) {
            body(element)
        }
    }
}
