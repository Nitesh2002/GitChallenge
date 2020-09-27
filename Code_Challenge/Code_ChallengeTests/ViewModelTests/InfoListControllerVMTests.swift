//
//  InfoListControllerVMTests.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import XCTest


class InfoListControllerVMTests: XCTestCase {

    var sut: InfoListControllerVM!
    
    override func setUp() {
        sut = InfoListControllerVM(infoServiceRequest: InfoWebserviceReequestsStub())
        sut.viewWillAppear()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testGetCellViewModelForIndexPath() {
        let cellViewModel = sut.getCellViewModel(for: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cellViewModel, "Cell view model for a valid index should not ideally be nil")
    }

    func testNumberOfRows() {
        XCTAssertLessThan(sut.getRowCount(), 100)
    }

    func testTitle() {
        XCTAssertEqual(sut.getTitle(), "")
    }
}
