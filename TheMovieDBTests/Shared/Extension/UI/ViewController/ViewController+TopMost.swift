//
//  ViewController+TopMost.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 17/04/2023.
//

import UIKit

extension UIViewController {
    var topmostViewController: UIViewController {
        if let presented = presentedViewController {
            return presented.topmostViewController
        }
        if let nav = self as? UINavigationController {
            return nav.visibleViewController?.topmostViewController ?? self
        }
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topmostViewController ?? self
        }
        return self
    }
}
