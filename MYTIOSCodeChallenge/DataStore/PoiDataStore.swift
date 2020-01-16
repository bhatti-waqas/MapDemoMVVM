//
//  PoiDataStore.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 16/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
private enum SearchBodyParameters: String {
    case p1Lat, p1Lon, p2Lat, p2Lon
}
//this protocl is for Objective-c classes
@objc protocol PoiDataStore {
    func getPois(with nePoint:Coordinate, swPoint: Coordinate,
        success: @escaping (_ json: [POI]?) -> (),
        failure: @escaping (_ error: NSError?) -> ()
    )
}

protocol PoiDataStoreProtocol {
    func getPois(with nePoint:Coordinate, swPoint: Coordinate) -> Observable<[POI]>
}

final class PoiAPIDataStore: NSObject, PoiDataStoreProtocol, PoiDataStore {
    
    let network:Networking = AlamofireNetwork.shared
    let baseUrl: String = APIURLs.baseURL
    let translation:TranslationLayer = JSONTranslation()
    
    @objc func getPois(with nePoint:Coordinate, swPoint: Coordinate,
        success: @escaping (_ json: [POI]?) -> (),
        failure: @escaping (_ error: NSError?) -> () ) {
        
        let dataRequest = CustomDataRequest(url: baseUrl)
        dataRequest.addQueryParameter(key: SearchBodyParameters.p2Lat, value: swPoint.latitude)
        dataRequest.addQueryParameter(key: SearchBodyParameters.p1Lon, value: nePoint.longitude)
        dataRequest.addQueryParameter(key: SearchBodyParameters.p1Lat, value: nePoint.latitude)
        dataRequest.addQueryParameter(key: SearchBodyParameters.p2Lon, value: swPoint.longitude)
        
        network.requestObject(dataRequest) { (response:DataResponseModel<POIResponseModel>) in
            switch response.result {
            case .success(let responseModel):
                success(responseModel.poiList)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
    /// returns Pois based on coordinates
    /// - Parameter nePoint: North West Coordinate
    /// - Parameter swPoint: South East Coordinate
    func getPois(with nePoint: Coordinate, swPoint: Coordinate) ->  Observable<[POI]> {
        let dataRequest = CustomDataRequest(url: baseUrl)
        dataRequest.addQueryParameter(key: SearchBodyParameters.p2Lat, value: swPoint.latitude)
        dataRequest.addQueryParameter(key: SearchBodyParameters.p1Lon, value: nePoint.longitude)
        dataRequest.addQueryParameter(key: SearchBodyParameters.p1Lat, value: nePoint.latitude)
        dataRequest.addQueryParameter(key: SearchBodyParameters.p2Lon, value: swPoint.longitude)
        
        return Observable.create { observer -> Disposable in
            self.network.requestObject(dataRequest) { (response:DataResponseModel<POIResponseModel>) in
                switch response.result {
                case .success(let responseModel):
                    observer.onNext(responseModel.poiList)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
