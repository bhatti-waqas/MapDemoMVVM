//
//  DataResponseHandler.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation

public enum ResultType<T> {
    case success(T)
    case failure(NetworkError)
}

public struct DataResponseModel<T> {
    public let result:ResultType<T>
}

