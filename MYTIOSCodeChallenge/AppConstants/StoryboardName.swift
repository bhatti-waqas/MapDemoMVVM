//
//  StoryboardName.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 19/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation

public enum StoryBoardName: String {
    case main = "Main"
    
    func create()->UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func create(_ id: String)->UIViewController {
        return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: id)
    }
    
    public func instantiateView<T>()->T where T:UIViewController {
        return self.create().instantiateViewController(withIdentifier: T.storyboardID) as! T
    }
}
