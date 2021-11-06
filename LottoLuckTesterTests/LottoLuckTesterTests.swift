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

    func testSimulation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        // Tests a three match lottery ticket
        let testCase1 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 3, nums: [33,1,3,4,34]),
                picked: LottoNumbers(powerBall: 4, nums: [33,1,4,2,13])
            ),
            expectedMoney: 10,
            match1: true,
            match2: true,
            match3: false,
            match4: true,
            match5: false,
            powerBallMatch: false,
            isJackPot: false
        )
        
        // Multiple numbers in picked and one number is in actual.  Only one should be allowed.  Tests powerball match as well
        let testCase2 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 3, nums: [1,4,53,22,4]),
                picked: LottoNumbers(powerBall: 3, nums: [44,1,3,2,1])
            ),
            expectedMoney: 4,
            match1: true,
            match2: false,
            match3: false,
            match4: false,
            match5: false,
            powerBallMatch: true,
            isJackPot: false
        )
        
        // Tests an out of order jackpot
        let testCase3 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 3, nums: [1,2,3,4,5]),
                picked: LottoNumbers(powerBall: 3, nums: [5,3,2,4,1])
            ),
            expectedMoney: 100_000_000,
            match1: true,
            match2: true,
            match3: true,
            match4: true,
            match5: true,
            powerBallMatch: true,
            isJackPot: true
        )
        
        let testCase4 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 3, nums: [1,1,3,4,5]),
                picked: LottoNumbers(powerBall: 3, nums: [23,23,33,1,1])
            ),
            expectedMoney: 10,
            match1: true,
            match2: true,
            match3: false,
            match4: false,
            match5: false,
            powerBallMatch: true,
            isJackPot: false
        )
        
        // Tests smallest money match
        let testCase5 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 31, nums: [1,3,3,4,5]),
                picked: LottoNumbers(powerBall: 31, nums: [23,23,33,33,15])
            ),
            expectedMoney: 2,
            match1: false,
            match2: false,
            match3: false,
            match4: false,
            match5: false,
            powerBallMatch: true,
            isJackPot: false
        )
        
        // Tests a 4 dollar match
        let testCase6 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 31, nums: [70,3,3,4,5]),
                picked: LottoNumbers(powerBall: 31, nums: [4,23,1,33,15])
            ),
            expectedMoney: 4,
            match1: false,
            match2: false,
            match3: false,
            match4: true,
            match5: false,
            powerBallMatch: true,
            isJackPot: false
        )
        
        // Tests a 200 dollar win
        let testCase7 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 31, nums: [1,3,3,4,5]),
                picked: LottoNumbers(powerBall: 31, nums: [3,23,1,33,5])
            ),
            expectedMoney: 200,
            match1: true,
            match2: true,
            match3: false,
            match4: false,
            match5: true,
            powerBallMatch: true,
            isJackPot: false
        )
        
        // Tests a 500 dollar win
        let testCase8 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 31, nums: [1,3,3,4,5]),
                picked: LottoNumbers(powerBall: 32, nums: [3,23,1,4,5])
            ),
            expectedMoney: 500,
            match1: true,
            match2: true,
            match3: false,
            match4: true,
            match5: true,
            powerBallMatch: false,
            isJackPot: false
        )
        
        // This testing 10_000 win
        let testCase9 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 23, nums: [1,3,3,4,5]),
                picked: LottoNumbers(powerBall: 23, nums: [3,23,1,4,5])
            ),
            expectedMoney: 10000,
            match1: true,
            match2: true,
            match3: false,
            match4: true,
            match5: true,
            powerBallMatch: true,
            isJackPot: false
        )
        
        // This testing 10_000 win
        let testCase10 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 23, nums: [1,3,3,4,5]),
                picked: LottoNumbers(powerBall: 33, nums: [3,3,1,4,5])
            ),
            expectedMoney: 1000000,
            match1: true,
            match2: true,
            match3: true,
            match4: true,
            match5: true,
            powerBallMatch: false,
            isJackPot: false
        )
        
        // This testing nothing matches
        let testCase11 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 23, nums: [2,3,3,4,5]),
                picked: LottoNumbers(powerBall: 33, nums: [32,13,1,43,51])
            ),
            expectedMoney: 0,
            match1: false,
            match2: false,
            match3: false,
            match4: false,
            match5: false,
            powerBallMatch: false,
            isJackPot: false
        )
        
        // This testing 1 non powerball matches
        let testCase12 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 23, nums: [2,3,3,4,5]),
                picked: LottoNumbers(powerBall: 33, nums: [32,1,1,43,5])
            ),
            expectedMoney: 0,
            match1: false,
            match2: false,
            match3: false,
            match4: false,
            match5: true,
            powerBallMatch: false,
            isJackPot: false
        )
        
        // This testing 1 non powerball matches
        let testCase13 = LottoResultTest(
            result: LottoResult(
                actual: LottoNumbers(powerBall: 23, nums: [2,3,3,4,51]),
                picked: LottoNumbers(powerBall: 33, nums: [32,3,1,43,51])
            ),
            expectedMoney: 0,
            match1: false,
            match2: true,
            match3: false,
            match4: false,
            match5: true,
            powerBallMatch: false,
            isJackPot: false
        )


        
        let testCases: Array<LottoResultTest> = [
            testCase1,
            testCase2,
            testCase3,
            testCase4,
            testCase5,
            testCase6,
            testCase7,
            testCase8,
            testCase9,
            testCase10,
            testCase11,
            testCase12,
            testCase13
        ]
        
        var simulator = LotterySimulationResult(
            pickedLottoNumbers: LottoNumbers(powerBall: 33, nums: [32,3,1,43,51]),  ticketsPerYear: 2)
        
        var expectedDollars = 0
        var expectedResultsSave = 0
        
        for testCase in testCases {
            XCTAssertEqual(testCase.match1, testCase.result.numbers.nums[0].isMatch)
            XCTAssertEqual(testCase.match2, testCase.result.numbers.nums[1].isMatch)
            XCTAssertEqual(testCase.match3, testCase.result.numbers.nums[2].isMatch)
            XCTAssertEqual(testCase.match4, testCase.result.numbers.nums[3].isMatch)
            XCTAssertEqual(testCase.match5, testCase.result.numbers.nums[4].isMatch)
            XCTAssertEqual(testCase.powerBallMatch, testCase.result.numbers.powerBall.isMatch)
            XCTAssertEqual(testCase.expectedMoney, testCase.result.dollars)
            XCTAssertEqual(testCase.isJackPot, testCase.result.isJackPot)
            
            // adds it to the simulator result
            simulator.addResult(testCase.result)
            
            // Collecting information in the loop so we don't have hard code things
            expectedDollars += testCase.expectedMoney
            
            // We should only save winning results over 100 dollars
            if (testCase.expectedMoney > 100) {
                expectedResultsSave += 1
            }
        }
        
        XCTAssertEqual(expectedDollars, simulator.won)
        XCTAssertEqual(expectedResultsSave, simulator.winningLottoResult.count)
        // We only had one jackpot in the set
        XCTAssertEqual(1, simulator.jackPots)
        // 13 * 2, 2 dollars is the price of the ticket
        XCTAssertEqual(26, simulator.spent)
        
        // Because we said 2 tickets per year and 13 tickets total we should have 6 years
        XCTAssertEqual(6, simulator.numberOfYears)


    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
