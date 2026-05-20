//
//  UIApplication+Extension.swift
//  SupportFund
//
//  Created by najak on 5/20/26.
//

import Foundation
import UIKit

extension UIApplication {
    func openURI(_ url: URL?, block: ((_ isSuccess: Bool) -> Void)? = nil) {
        if let openUrl = url {
            UIApplication.shared.open(openUrl, options: [:]) { (isSuccess) in
                block?(isSuccess)
            }
        } else {
            block?(false)
        }
    }
}
