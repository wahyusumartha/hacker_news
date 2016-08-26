//
//  StringAdditions.swift
//  Boilerplate
//
//  Created by Khoi Truong Minh on 7/11/16.
//  Copyright © 2016 Innovatube. All rights reserved.
//

import UIKit

extension String {

    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: [.UsesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }

    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.max, height: height)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: [.UsesFontLeading, .UsesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }

    func heightWithFont(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.max, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: [.UsesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }

    func widthWithFont(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.max, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: [.UsesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }

    func attributedText(highlightedKeyword keyword: String, attributes: [String: AnyObject]) -> NSAttributedString? {
        let attributedText = NSMutableAttributedString(string: self)
        var searchRange = NSRange(location: 0, length: characters.count)
        var foundRange = NSRange()
        while searchRange.location < characters.count {
            searchRange.length = characters.count - searchRange.location
            let originString = (lowercaseString as NSString)
            foundRange = originString.rangeOfString(keyword.lowercaseString, options: [], range: searchRange)
            attributedText.addAttributes(attributes, range: foundRange)
            if foundRange.location != NSNotFound {
                searchRange.location = foundRange.location + foundRange.length
            } else {
                break
            }
        }
        return attributedText
    }

}
