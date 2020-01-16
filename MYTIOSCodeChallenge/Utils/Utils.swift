//
//  Util.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation

public class Run {
    
    public class func onMainThread(after delay:Double = 0, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    public class func onBackgroundThread(after delay:Double = 0, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.global().asyncAfter(deadline: when, execute: closure)
    }
}
