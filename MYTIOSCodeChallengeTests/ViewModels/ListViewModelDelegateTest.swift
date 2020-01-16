//
//  ListViewModelDelegateTest.swift
//  MYTIOSCodeChallengeTests
//
//  Created by Waqas Naseem on 21/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import XCTest
@testable import MYTIOSCodeChallenge
class ListViewModelDelegateTest: XCTestCase {
    
    var isDelegateCalled: Bool = false
    
    override func tearDown() {
        isDelegateCalled = false
    }

    func testListViewModelDelegateCalledOnSuccess() {
        //1. given
        let dataStore = MockStore()
        dataStore.getPoisResult = .success([POI()])
        let viewModel = ListViewModel(dataStore: dataStore)
        viewModel.delegate = self
        //2. when
        viewModel.load()
        //3. then
        XCTAssertTrue(isDelegateCalled, "Delegate should be called")
    }
    
    func testListViewModelDelegateCalledOnFailure() {
        //1. given
        let dataStore = MockStore()
        dataStore.getPoisResult = .failure(NetworkError.RequestFailed)
        let viewModel = ListViewModel(dataStore: dataStore)
        viewModel.delegate = self
        //2. When
        viewModel.load()
        //3. then
        XCTAssertTrue(isDelegateCalled, "Delegate should be called on error")
    }
}
//MARK: ListViewModelDelegate Methods
extension ListViewModelDelegateTest: ListViewModelDelegate {
    func onListViewModelReady() {
        isDelegateCalled = true
    }
    
    func onListViewModelError(_ error: Error) {
        isDelegateCalled = true
    }
    
    
}
