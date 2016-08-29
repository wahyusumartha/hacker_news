//
//  UIImageAdditions.swift
//  Boilerplate
//
//  Created by Khoi Truong Minh on 7/12/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import UIKit

extension UIImage {

    func colorizeWith(color color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        CGContextTranslateCTM(context, 0, size.height)
        CGContextScaleCTM(context, 1.0, -1.0)

        // set the blend mode to color burn, and the original image
        CGContextSetBlendMode(context, .Normal)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        CGContextDrawImage(context, rect, CGImage)

        // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
        CGContextClipToMask(context, rect, CGImage)
        CGContextAddRect(context, rect)
        CGContextDrawPath(context, .Fill)

        // generate a new UIImage from the graphics context we drew onto
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        //return the color-burned image
        return coloredImage
    }

}
