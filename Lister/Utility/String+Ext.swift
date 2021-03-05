//
//  String+Ext.swift
//  Lister
//
//  Created by Rajkumar Kothandaraman on 05/03/2021.
//

import Foundation

public extension String {
    var escapedQuery: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
}
