//
//  ExtensionClass.swift
//  EnvoyFloatingMenu
//
//  Created by Faisal on 24/07/18.
//  Copyright © 2018 Faisal. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton
{
    func alignTextBelow(spacing: CGFloat = 10)
    {
        if let image = self.imageView?.image
        {
            self.imageView?.contentMode = .scaleAspectFit
            self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0,bottom: 0.0, right: -titleSize.width)
        }
    }
}

extension NSObject
{
    class var className: String
    {
        return String(describing: self)
    }
}
