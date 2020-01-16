//
//  MapViewModelTests.swift
//  MYTIOSCodeChallengeTests
//
//  Created by Waqas Naseem on 20/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import XCTest
import RxSwift
import MapKit
@testable import MYTIOSCodeChallenge
class MapViewModelTests: XCTestCase {

    /// Test successfully  looading of Pois
    func testLoadPoisSuccessfully() {
        let disposeBag = DisposeBag()
        let dataStore = MockDataStore()
        dataStore.getPoisResult = .success([POI()])
        let viewModel = MapViewModel(dataStore)
        
        // Given
        let nECoord = Coordinate(latitude: 53.694865, longitude: 9.757589)
        let sWCoord = Coordinate(latitude: 53.394655, longitude: 10.099891)
        
        // 1
        let promise = expectation(description: "Annotatiosn count isn't zero")
        
        viewModel.onShowAnnotations.subscribe { annotations in
            //then
            XCTAssertTrue(annotations.element?.count ?? 0 > 0, "Valid search Coordinates, annotations not be zero.")
            promise.fulfill()
        }.disposed(by: disposeBag)
        //When
        viewModel.load(nECoord, southWestCoordinate: sWCoord)
        wait(for: [promise], timeout: 10)
    }
    
    /// Failure case test
    func testLoadPoisFailure() {
        let disposeBag = DisposeBag()
        let dataStore = MockDataStore()
        dataStore.getPoisResult = .failure(NetworkError.RequestFailed)
        let viewModel = MapViewModel(dataStore)

        // Given
        let nECoord = Coordinate(latitude: 53.694865, longitude: 9.757589)
        let sWCoord = Coordinate(latitude: 53.394655, longitude: 10.099891)
        // 1
        let expectErrorShown = expectation(description: "Error  is shown")
        
        viewModel.onShowError.subscribe { error in
            //then
            XCTAssertNotNil(error.element, "Error shouldn't be nil")
            expectErrorShown.fulfill()
        }.disposed(by: disposeBag)

        //When
        viewModel.load(nECoord, southWestCoordinate: sWCoord)
        wait(for: [expectErrorShown], timeout: 10)
    }
    
    /// Test to see if viewModel's load method is getting called whenever map bound is getting changed
    func testViewModelLoadMethodCallingOnMapRectChange() {
        //given
        let dataStore = MockDataStoreViewModelLoad()
        let mapViewModel = MapViewModel(dataStore)
        let mapViewController = MapViewController(with: mapViewModel)
        //when
        mapViewController.mapViewDidChangeVisibleRegion(MKMapView())
        //then
        XCTAssertTrue(dataStore.isLoadMethodCalled, "Load method of view model isn't getting called")
    }
}


