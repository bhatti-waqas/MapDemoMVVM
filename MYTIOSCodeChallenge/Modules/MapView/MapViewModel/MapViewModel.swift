//
//  MapViewModel.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 17/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import Foundation
import MapKit
import RxSwift

public class MapViewModel {
    // on startup initial coordinates to set region
    let initialNECoordinate = Coordinate(latitude: 53.694865, longitude: 9.757589)
    let initialSWCoordinate = Coordinate(latitude: 53.394655, longitude: 10.099891)
    var dataStore: PoiDataStoreProtocol
    var pois: [POI]? = nil
    let onShowAnnotations = PublishSubject<[MKAnnotation]>()
    let onShowError = PublishSubject<NetworkError>()
    let disposeBag = DisposeBag()
    
    init(_ dataStore: PoiDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func load(_ northEastCoordinate: Coordinate, southWestCoordinate: Coordinate) {
        dataStore.getPois(with: northEastCoordinate, swPoint: southWestCoordinate)
        .subscribe(
            onNext: {[weak self] pois in
                //store pois
                self?.pois = pois
                self?.createAndPublishAnnotations()
            },
            onError: {[weak self] error in
                self?.onShowError.onNext(error as! NetworkError)
            }
        )
        .disposed(by: disposeBag)
    }
    
    /// Create annotations from POIs
    private func getAnnotations() -> [MKAnnotation] {
        var annotations: [MKAnnotation] = []
        guard let pois = self.pois else{ return [] }
        for poi in pois {
            let annotation = MKPointAnnotation()
            annotation.title = poi.fleetType
            annotation.coordinate = CLLocationCoordinate2D(latitude:CLLocationDegrees(poi.coordinate.latitude), longitude: CLLocationDegrees(poi.coordinate.longitude))
            annotations.append(annotation)
        }
        return annotations
    }
    
    private func createAndPublishAnnotations() {
        onShowAnnotations.onNext(getAnnotations())
    }
    
    // MARK: - Map Coord Helpers
    public func getInitialStateCenterRegion() -> MKCoordinateRegion {
        let centerPoint = CLLocationCoordinate2DMake((initialNECoordinate.latitude + initialSWCoordinate.latitude)/2, (initialSWCoordinate.longitude + initialNECoordinate.longitude)/2)
        let floatForRadiusInMiles = 10.0 // we can ignore this i have taken this for my custom radius property
        let scalingFactor: Double = abs((cos(2 * Double.pi * centerPoint.latitude / 360.0)))
        let coordinateSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: floatForRadiusInMiles / 69.0, longitudeDelta: floatForRadiusInMiles / (scalingFactor * 69.0))
        return MKCoordinateRegion(center: centerPoint, span: coordinateSpan)
    }
    
    public func getNorthEastCoordinate(with mapView: MKMapView) -> Coordinate {
        let nePoint = CGPoint(x: mapView.bounds.origin.x + mapView.bounds.size.width, y: mapView.bounds.origin.y)
        let neCoord = mapView.convert(nePoint, toCoordinateFrom: mapView)
        return Coordinate(latitude: neCoord.latitude, longitude: neCoord.longitude)
    }
    
    public func getSouthWestCoordinate(with mapView: MKMapView) -> Coordinate {
        let swPoint = CGPoint(x: (mapView.bounds.origin.x), y: (mapView.bounds.origin.y + mapView.bounds.size.height))
        let swCoord = mapView.convert(swPoint, toCoordinateFrom: mapView)
        return Coordinate(latitude: swCoord.latitude, longitude: swCoord.longitude)
    }
}
