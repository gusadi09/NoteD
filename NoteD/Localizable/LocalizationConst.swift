//
//  LocalizationConst.swift
//  NoteD
//
//  Created by Gus Adi on 15/07/21.
//

import Foundation

protocol LocalizationProtocol {
    func localized() -> String
    var value: String { get }
}

extension LocalizationProtocol {
    func localized() -> String {
        
        let result = NSLocalizedString(value, comment: "")
        if result != value {
            return result
        }

        // Fall back to en
        guard
            let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
            let bundle = Bundle(path: path)
            else { return value }
        return NSLocalizedString(value, bundle: bundle, comment: "")
    }
}

enum LocalizationConst {
    enum Shared : String, LocalizationProtocol {
        
        case appstitle = "appstitle"
        
        var value:String {
            get {
                "shared_\(self.rawValue)"
            }
        }
    }
}
