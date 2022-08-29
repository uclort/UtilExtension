//
//  HmDataExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/9/2.
//

import Foundation

public extension HmUtils where Util == Data {
    func decoded<T: Decodable>(_: T.Type) -> T? {
        guard let model = try? JSONDecoder().decode(T.self, from: util) else {
            return nil
        }
        return model
    }
}
