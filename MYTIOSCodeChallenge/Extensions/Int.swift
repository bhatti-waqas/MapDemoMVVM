//
//  Int.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 16/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

public extension Int {
    func toString()->String {
        return String(self)
    }
}

public extension Double {
    func toString() -> String {
        return String(format: "%f", self)
    }
}
