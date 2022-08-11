//
//  NSAttributedString+SAK.swift
//  NASA
//
//  Created by Susan Kern on 8/11/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import UIKit

extension NSAttributedString {

    // MARK: - Initialization

    convenience init?(HTMLString: String) {
        // Specify string as UTF8, HTML
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                       NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue] as [NSAttributedString.DocumentReadingOptionKey : Any]
        do {
            try self.init(data: HTMLString.data(using: String.Encoding.utf8)!,
                          options: options,
                          documentAttributes: nil)
        } catch let error as NSError {
            print("\(error.description)")
            return nil
        }
    }


    // MARK: - Helpers

    static func defaultHTMLTextStyle(_ fontSize: String) -> String {
        return """
        <meta charset=\"UTF-8\">
        <style> 
            body { font-family: 'Avenir-Light'; font-size: \(fontSize); } 
            a { font-family: 'Avenir-Light'; color:blue; } 
            b { font-family: 'Avenir-Medium'; color:blue; } 
            strong { font-family: 'Avenir-Medium'; color:blue; } 
        </style>
        """
    }

    static func textFromHTMLString(_ fontSize: String = "16px", HTML: String) -> NSAttributedString? {
        let styleString = "\(defaultHTMLTextStyle(fontSize))\(HTML)"
        return NSAttributedString(HTMLString: styleString)
    }
}
