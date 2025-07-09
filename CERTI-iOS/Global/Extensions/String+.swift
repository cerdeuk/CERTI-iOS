//
//  String+.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/10/25.
//

import Foundation

extension String {
    var antiAppleBySangyup: Self {
        self.map({ String($0) }).joined(separator: "\u{200B}")
    }
}
