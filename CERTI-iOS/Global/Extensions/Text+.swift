//
//  Text+.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/8/25.
//

import SwiftUI

extension Text {
    static func trimmedUsername(_ username: String) -> Text {
        if username.count == 3 {
            return Text(username)
        } else {
            return Text("\(username.prefix(3))...")
        }
    }
}
