//
//  String+Extensions.swift
//  Parade
//
//  Created by Łukasz Szymczuk on 06/03/2023.
//

import Foundation

public extension String {
    /// Returns localized string.
    var localized: String {
        let localizedString = NSLocalizedString(self, bundle: Bundle.main, comment: self)
        if localizedString.isEmpty {
            return enLocalized
        }
        return localizedString
    }
    
    /// returns localized string in english or empty string
    var enLocalized: String {
        if let enPath = Bundle.main.path(forResource: "en", ofType: "lproj") {
            let enBundle = Bundle(path: enPath)
            return enBundle?.localizedString(forKey: self, value: self, table: nil) ?? ""
        }
        return ""
    }
    
}
