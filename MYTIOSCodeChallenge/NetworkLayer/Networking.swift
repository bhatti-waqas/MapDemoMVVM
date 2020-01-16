//
//  Networking.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation
import Alamofire
public typealias DataResponseHandler<T> = (DataResponseModel<T>) -> Void
public typealias ResultHandler<T> = (ResultType<T>) -> Void

public protocol Networking {

    func requestObject<T:Decodable>(_ request: URLRequestConvertible,completionHandler: @escaping DataResponseHandler<T>)
}
