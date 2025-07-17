//
//  UINavigationController+.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/18/25.
//

import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return SwipePopGestureManager.shared.isAllowPopGesture && viewControllers.count > 1
    }
}
