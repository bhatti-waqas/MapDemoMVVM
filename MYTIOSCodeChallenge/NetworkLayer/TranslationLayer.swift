//
//  TranslationLayer.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//
import Foundation
public enum TranslationLayerError:Error {
    case encodingFailed
}

public protocol TranslationLayer {
    func encode<T:Encodable>(withModel model:T) throws -> [String:Any]
    func decode<T:Decodable>(withData data:Data) throws -> T
}
