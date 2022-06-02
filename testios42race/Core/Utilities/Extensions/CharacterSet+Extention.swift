//
//  CharacterSet+Extention.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 03/06/22.
//

import Foundation
extension CharacterSet {
    var allCharacters: [Character] {
        var result: [Character] = []
        for plane: UInt8 in 0...16 where self.hasMember(inPlane: plane) {
            for unicode in UInt32(plane) << 16 ..< UInt32(plane + 1) << 16 {
                if let uniChar = UnicodeScalar(unicode), self.contains(uniChar) {
                    result.append(Character(uniChar))
                }
            }
        }
        return result
    }
}
