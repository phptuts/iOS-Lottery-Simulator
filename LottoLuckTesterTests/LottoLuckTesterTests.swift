//
//  LottoLuckTesterTests.swift
//  LottoLuckTesterTests
//
//  Created by Noah Glaser on 11/4/21.
//

import XCTest
@testable import LottoLuckTester

// Creating a test struct to make it easy to test lotto results
// It contains the lotto results and expected values so that I can put them in a loop
// And test them with a lottery simulation
struct LottoResultTest {
    let result: LottoResult
    let expectedMoney: Int
    let match1: Bool
    let match2: Bool
    let match3: Bool
    let match4: Bool
    let match5: Bool
    let powerBallMatch: Bool
    let isJackPot: Bool
}

class LottoLuckTesterTests: XCTestCase {

    
    
    
    /**
     * This should return 10 dollar amount
     */
    func testSimpleSimulation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let result1 = LottoResult(actual: LottoNumbers(powerBall: 3, nums: [33,1,3,4,34]), picked: LottoNumbers(powerBall: 4, nums: [33,1,4,2,13]))
        
        let testCase1 = LottoResultTest(
            result: result1,
            expectedMoney: 10,
            match1: true,
            match2: true,
            match3: false,
            match4: true,
            match5: false,
            powerBallMatch: false,
            isJackPot: false
        )

        
        let testCases: Array<LottoResultTest> = [testCase1]
        
        for testCase in testCases {
            XCTAssertEqual(testCase.match1, testCase.result.numbers.nums[0].isMatch)
            XCTAssertEqual(testCase.match2, testCase.result.numbers.nums[1].isMatch)
            XCTAssertEqual(testCase.match3, testCase.result.numbers.nums[2].isMatch)
            XCTAssertEqual(testCase.match4, testCase.result.numbers.nums[3].isMatch)
            XCTAssertEqual(testCase.match5, testCase.result.numbers.nums[4].isMatch)
            XCTAssertEqual(testCase.powerBallMatch, testCase.result.numbers.powerBall.isMatch)
            XCTAssertEqual(testCase.expectedMoney, testCase.result.dollars)
            XCTAssertEqual(testCase.isJackPot, testCase.result.isJackPot)

        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
