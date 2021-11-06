//
//  LotteryCalculator.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/16/21.
//

import Foundation

// The amount of money won when all numbers are guessed
let JACKPOT = 100_000_000

typealias MEGAMILLION_NUMBER = Int
typealias POWERBALL_NUMBER = Int

// Represents a lotto number
struct LottoNumbers {
    let powerBall: POWERBALL_NUMBER
    let nums: Array<MEGAMILLION_NUMBER>
}

// Contains a the numbers selected and whether they are winning numbers or not
struct LottoNumberMatches {
    let powerBall: (number: MEGAMILLION_NUMBER, isMatch: Bool)
    let nums: Array<(number: MEGAMILLION_NUMBER, isMatch: Bool)>
}



// Represents the result of picking a lotto number and the amount won off that LottoPick
struct LottoResult {
    let numbers: LottoNumberMatches
    
    init ( actual: LottoNumbers,  picked: LottoNumbers) {
        var userPickedNumbers = picked.nums
        let actualLotteryNumbers = actual.nums;
        
        // It's being done this way to account for the same number being in the lotto multiple times
        // For example if the user selects [33,33,2,31,3] and what is picked is [1,33,23,13,3]
        // They should only get one of the 33 and not both.  The order does not matter.
        // This why I remove one of the items in the number list so that only get credit for one and why we
        // can't use something simple like contains which normally would be a better choice.
        let resultNums: Array<(Int, Bool)> = actualLotteryNumbers.map {
            let index = userPickedNumbers.firstIndex(of: $0)
            
            if index == nil {
                return ($0, false)
            }
             
            userPickedNumbers.remove(at: index ?? 0)
            return ($0, true)
        }
    
        self.numbers = LottoNumberMatches(powerBall: (actual.powerBall, picked.powerBall == actual.powerBall), nums: resultNums)
    }
    
    var dollars: Int {
        let numberOfMatches = self.numbers.nums.filter { value in
            return value.isMatch
        }.count
        
        let powerBallMatch = self.numbers.powerBall.isMatch
            
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
    
    var isJackPot: Bool {
        return self.dollars == JACKPOT
    }
}

// This struct is used build result over time.
// I decided not to store all the lotto results for memory reasons
struct LotterySimulationResult {
    
    let pickedLottoNumbers: LottoNumbers
    let ticketsPerYear: Int
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
        
        if (result.isJackPot) {
            self.jackpots += 1
        }
    }
    
    var won: Int {
        return self.totalDollars
    }
    
    var spent: Int {
        return self.timesPlayed * 2
    }
    
    var jackPots: Int {
        return self.jackpots
    }
    
    var numberOfYears:  Int {
        return Int(self.timesPlayed / self.ticketsPerYear)
    }
}


// Runs the simulation
func runSimulation(_ pickedLottoNumbers: LottoNumbers) -> LottoResult {
    let randonNums = Array(0...4).map {  _ in Int.random(in: 1..<71) }
    let powerBallNumber = Int.random(in: 1..<26)
    let randomLottoNumbers = LottoNumbers(powerBall: powerBallNumber, nums: randonNums)
    
    return LottoResult(actual: randomLottoNumbers, picked: pickedLottoNumbers)
}




