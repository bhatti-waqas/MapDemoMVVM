//
//  AlertHandler.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

class AlertHandler: NSObject {
    
    public static func showError(_ controller:UIViewController, error: NetworkError) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    public static func showAlert(_ controller:UIViewController,title:String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    @objc public static func showError(_ controller:UIViewController, error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
