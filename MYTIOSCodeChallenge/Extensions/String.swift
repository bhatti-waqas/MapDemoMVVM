//
//  String.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 16/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation

extension String {
    
    public func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    public func img() -> UIImage {
        return UIImage(named: self) ?? UIImage()
    }
    
    public func escape()->String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    public func concat(urlPath:String)->String {
        return self + (self.hasSuffix("/") ? "" : "/") +  urlPath
    }
}
