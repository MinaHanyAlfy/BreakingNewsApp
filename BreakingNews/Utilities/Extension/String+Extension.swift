//
//  String+Extension.swift
//  BreakingNews
//
//  Created by Mina Hanna on 2023-08-14.
//

import Foundation

extension String {
    func localizeString(string: String) -> String {
            let path = Bundle.main.path(forResource: string, ofType: "lproj")
            let bundle = Bundle(path: path!)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
