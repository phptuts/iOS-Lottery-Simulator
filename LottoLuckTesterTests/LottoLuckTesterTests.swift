//
//  LottoLuckTesterTests.swift
//  LottoLuckTesterTests
//
//  Created by Noah Glaser on 11/4/21.
//

import XCTest
@testable import LottoLuckTester

class LottoLuckTesterTests: XCTestCase {

    
    /**
     * This should return 10 dollar amount
     */
    func testLottoMatch3NonPowerBall() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let lottoPicked =  LottoNumbers(powerBall: 3, nums: [33,1,3,4,34])
        let userPicked = LottoNumbers(powerBall: 4, nums: [33,1,4,2,13])
        let result = LottoResult(lottoPicked, userPicked)
        
        XCTAssertTrue(result.numbers.nums[0].isMatch)
        XCTAssertTrue(result.numbers.nums[1].isMatch)
        XCTAssertFalse(result.numbers.nums[2].isMatch)
        XCTAssertTrue(result.numbers.nums[3].isMatch)
        XCTAssertFalse(result.numbers.nums[4].isMatch)
        XCTAssertFalse(result.numbers.powerBall.isMatch)
        
        XCTAssertEqual(10, result.dollars)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
