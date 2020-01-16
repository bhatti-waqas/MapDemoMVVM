//
//  ListViewModelTests.swift
//  MYTIOSCodeChallengeTests
//
//  Created by Waqas Naseem on 21/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import XCTest
@testable import MYTIOSCodeChallenge
class ListViewModelTests: XCTestCase {

    func testViewModelPopulatesRowsSuccessfully() {
        //1. given
        let dataStore = MockStore()
        dataStore.getPoisResult = .success([POI()])
        let viewModel = ListViewModel(dataStore: dataStore)
        
        let promise = expectation(description: "Number of cell shoudn't be zero")
        
        //when
        viewModel.load()
        
        //then
        Run.onMainThread(after: 1) {
            let numberOfRows = Int(bitPattern: viewModel.getNumberOfRows())
            XCTAssertTrue(numberOfRows > 0, "Rows not populated")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }
    
    //Test Failure case
    func testViewModelPopulatesError() {
        //1. given
        let dataStore = MockStore()
        dataStore.getPoisResult = .failure(NetworkError.RequestFailed)
        let viewModel = ListViewModel(dataStore: dataStore)
        let promise = expectation(description: "Error shouldn't be nil")
        //2. When
        viewModel.load()
        //3. then
        Run.onMainThread(after: 1) {
            XCTAssertNotNil(viewModel.getErrorReturned(), "Error shouldn't be nil")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }
    
    func testListCellViewModelCreation() {
        //1. given
        let dataStore = MockStore()
        //creating mock store with one POI object
        dataStore.getPoisResult = .success([POI()])
        let viewModel = ListViewModel(dataStore: dataStore)
        let promise = expectation(description: "List Cell view should be created")
        //2. When
        viewModel.load()
        //3. then
        Run.onMainThread(after: 1) {
            XCTAssertNotNil(viewModel.getListCellViewModel(at: 0), "ListCellViewModel should be created")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }
}

final class MockStore: PoiDataStore {
    var getPoisResult: ResultType<[POI]>?
    
    func getPois(with nePoint: Coordinate, swPoint: Coordinate, success: @escaping ([POI]?) -> (), failure: @escaping (NSError?) -> ()) {
        switch self.getPoisResult {
        case .success(let pois):
            success(pois)
        case .failure(let error):
            failure(error as NSError)
        default:
            failure(NSError(domain: "Network Error", code: 500, userInfo: nil))
        }
    }
}


