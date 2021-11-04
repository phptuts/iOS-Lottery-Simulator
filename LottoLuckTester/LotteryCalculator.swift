//
//  LotteryCalculator.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/16/21.
//

import Foundation

// The amount of money won when all numbers are guessed
let JACKPOT = 100_000_000

// Represents a lotto number
struct LottoNumbers {
    let powerBall: Int
    let nums: Array<Int>
}

// Contains a the numbers selected and whether they are winning numbers or not
struct LottoNumberResult {
    let powerBall: (Int, Bool)
    let nums: Array<(Int, Bool)>
}



// Represents the result of picking a lotto number and the amount won off that LottoPick
struct LottoResult {
    let numbers: LottoNumberResult
    let dollars: Int
    
    func isJackPot() -> Bool {
        return self.dollars == JACKPOT
    }
}

// This struct is used build result over time.
// I decided not to store all the lotto results for memory reasons
struct LotterySimulationResult {
    
    let pickedLottoNumbers: LottoNumbers
    var winningLottoResult: [LottoResult] = []
    var timesPlayed: Int = 0
    var jackpots: Int = 0
    var totalDollars = 0
    
    mutating func addResult(_ result: LottoResult) {
        self.timesPlayed += 1
        self.totalDollars += result.dollars
        if (result.dollars >= 100) {
            self.winningLottoResult.append(result)
        }
        
        if (result.isJackPot()) {
            self.jackpots += 1
        }
    }
    
    func won() -> Int {
        return self.totalDollars
    }
    
    func spent() -> Int {
        return self.timesPlayed * 2
    }
    
    func jackPots() -> Int {
        return self.jackpots
    }
    
    func numberOfYears(ticketsPerYear: Int) -> Int {
        return Int(self.timesPlayed / ticketsPerYear)
    }
}
// Takes in the picked lotto number and actual choosen lotto number and creates a result object
func toLottoNumberResult(_ picked: LottoNumbers, _ actual: LottoNumbers) -> LottoNumberResult {
    var userPickedNumbers = picked.nums
    let actualLotteryNumbers = actual.nums;
    
    let resultNums: Array<(Int, Bool)> = actualLotteryNumbers.map {
        let index = userPickedNumbers.firstIndex(of: $0)
        
        if index == nil {
            return ($0, false)
        }
         
        userPickedNumbers.remove(at: index ?? 0)
        return ($0, true)
    }
        
    return LottoNumberResult(powerBall: (actual.powerBall, picked.powerBall == actual.powerBall), nums: resultNums)
}

// calculates the money won
func calculateMoney(_ result: LottoNumberResult) -> Int {
    
    let numberOfMatches = result.nums.filter { value in
        return value.1
    }.count
    
    let powerBallMatch = result.powerBall.1
        
    let winningMatrix: [String: Int] = [
        "true-0": 2,
        "true-1": 4,
        "true-2": 10,
        "false-3": 10,
        "true-3": 200,
        "false-4": 500,
        "true-4": 10_000,
        "false-5": 1_000_000,
        "true-5": JACKPOT
    ]
    
    guard let money = winningMatrix["\(powerBallMatch)-\(numberOfMatches)"] else {
        return 0
    }
    
    return money
}

// Runs the simulation
func runSimulation(_ pickedLottoNumbers: LottoNumbers) -> LottoResult {
    let randonNums = Array(0...4).map {  _ in Int.random(in: 1..<71) }
    let powerBallNumber = Int.random(in: 1..<26)
    let randomLottoNumbers = LottoNumbers(powerBall: powerBallNumber, nums: randonNums)
    let lottoNumberResult = toLottoNumberResult(pickedLottoNumbers, randomLottoNumbers)
    let money = calculateMoney(lottoNumberResult)
    
    return LottoResult(numbers: lottoNumberResult, dollars: money)
}




