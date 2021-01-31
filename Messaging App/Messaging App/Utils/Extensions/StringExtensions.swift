//
//  StringExtensions.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 2.03.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func isValidIdNumber() -> Bool {
        
        let digits = self.map {Int(String($0)) ?? -1}

        if digits.contains(-1) {
            return false
        }
        
        if digits.count == 11 {
            if digits.first != 0 {
                let first   = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
                let second  = (digits[1] + digits[3] + digits[5] + digits[7])
                
                let digit10 = (first - second) % 10
                let digit11 = (digits[0] + digits[1] + digits[2] + digits[3] + digits[4] + digits[5] + digits[6] + digits[7] + digits[8] + digits[9]) % 10
                
                if (digits[10] == digit11) && (digits[9] == digit10) {
                    return true
                }
            }
        }
        return false
    }
    
    var isValidEmail: Bool {
        get {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: self)
        }
    }
    
    var isValidName: Bool {
        get {
            let fullName = self.components(separatedBy: " ")
            if fullName.count > 1 {
                if fullName[0].count > 1 && fullName[1].count > 1 { return true }
            }
            return false
        }
    }
    
    var formatPhoneNumber: String {
        get {
            return self
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
                .replacingOccurrences(of: "-", with: "")
        }
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func containsOnlyDigits() -> Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        if rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil {
            return true
        }
        return false
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }

    var storyboardLocalized: String {
        return NSLocalizedString(self, tableName: "StoryboardLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
    
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet, options: String.CompareOptions.caseInsensitive) == nil
    }
    
    func format(_ args: [CVarArg]) -> String {
        return String.init(format: self, arguments: args)
    }
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
            0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
    
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, options: [], range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: NSAttributedString? {
        return htmlToAttributedString
    }
    
    var turkishUppercased: String {
        return self.uppercased(with: Locale(identifier: "tr_TR"))
    }
}


extension NSAttributedString {
    convenience init(format: NSAttributedString, attributes: [NSAttributedString.Key: Any]? = nil, args: NSAttributedString...) {
        let mutableNSAttributedString = NSMutableAttributedString(attributedString: format)

        args.forEach { (attributedString) in
            let range = NSString(string: mutableNSAttributedString.string).range(of: "%@")
            mutableNSAttributedString.replaceCharacters(in: range, with: attributedString)
        }
        
        if let attributes = attributes {
            mutableNSAttributedString.addAttributes(attributes, range: NSRange(location: 0, length: mutableNSAttributedString.length))
        }
        
        self.init(attributedString: mutableNSAttributedString)
    }
}
