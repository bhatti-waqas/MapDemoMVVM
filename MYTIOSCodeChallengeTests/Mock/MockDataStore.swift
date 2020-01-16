//
//  StubPoiDataStore.swift
//  MYTIOSCodeChallengeTests
//
//  Created by Waqas Naseem on 20/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation
import RxSwift
@testable import MYTIOSCodeChallenge
final class MockDataStore: PoiDataStoreProtocol {
    var getPoisResult: ResultType<[POI]>?
    
    func getPois(with nePoint: Coordinate, swPoint: Coordinate) -> Observable<[POI]> {
        return Observable.create { observer in
            switch self.getPoisResult {
            case .success(let response)?:
                observer.onNext(response)
            case .failure(let error)?:
                observer.onError(error)
            case .none:
                observer.onError(NetworkError.RequestFailed)
            }
            return Disposables.create()
        }
    }
}

final class MockDataStoreViewModelLoad: PoiDataStoreProtocol {
    var isLoadMethodCalled: Bool = false
    
    func getPois(with nePoint: Coordinate, swPoint: Coordinate) -> Observable<[POI]> {
        isLoadMethodCalled = true
        return .empty()
    }
}

