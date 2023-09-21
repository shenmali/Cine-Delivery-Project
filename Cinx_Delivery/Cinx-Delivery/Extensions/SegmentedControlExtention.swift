//
//  Cinx-Delivery
//
//  Created by Ali on 19/09/2023.
//

import UIKit
extension UISegmentedControl
{
    func setOldLayout(tintColor: UIColor)
    {
        if #available(iOS 13, *)
        {
            let bg = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
             let devider = UIImage(color: tintColor, size: CGSize(width: 1, height: 32))

             //set background images
             self.setBackgroundImage(bg, for: .normal, barMetrics: .default)
             self.setBackgroundImage(devider, for: .selected, barMetrics: .default)

             //set divider color
             self.setDividerImage(devider, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

             //set border
             self.layer.borderWidth = 1
             self.layer.borderColor = tintColor.cgColor

             //set label color
             self.setTitleTextAttributes([.foregroundColor: tintColor], for: .normal)
             self.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        }
        else
        {
            self.tintColor = tintColor
        }
    }
}
extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.init(data: image.pngData()!)!
    }
}
