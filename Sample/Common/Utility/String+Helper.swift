//
//  String+Helper.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 24.09.2020.
//

import Foundation
import UIKit

extension String {
    func boundingSize(with size: CGSize, options lineOptions: NSStringDrawingOptions, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let stringSize = NSString(string: self).boundingRect(with: size, options: lineOptions, attributes: attributes, context: nil).size

        return CGSize.init(width: stringSize.width, height: stringSize.height.rounded())
    }
}
