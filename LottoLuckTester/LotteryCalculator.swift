//
//  LotteryCalculator.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/16/21.
//

import Foundation


let JACKPOT = 100_000_000

struct LottoNumbers {
    let powerBall: Int
    let nums: Array<Int>
}

struct LottoResult {
    let numbers: LottoNumbers
    let dollars: Int
    
    func isJackPot() -> Bool {
        return self.dollars == JACKPOT
    }
}

struct LotterySimulationResult {
    
    let pickedLottoNumbers: LottoNumbers
    var winningLottoResult: [LottoResult] = []
    var timesPlayed: Int = 0
    var jackpots: Int = 0
    
    mutating func addResult(_ result: LottoResult) {
        self.timesPlayed += 1
        if (result.dollars > 0) {
            self.winningLottoResult.append(result)
        }
        
        if (result.isJackPot()) {
            self.jackpots += 1
        }
    }
    
    func won() -> Int {
        return self.winningLottoResult.map { $0.dollars }.reduce(0, +)
    }
    
    func spent() -> Int {
        return self.timesPlayed * 2
    }
    
    func jackPots() -> Int {
        return self.jackpots
    }
}

func runSimulation(_ pickedLottoNumbers: LottoNumbers) -> LottoResult {
    let randonNums = Array(0...4).map {  _ in Int.random(in: 1..<71) }
    let powerBallNumber = Int.random(in: 1..<26)
    let randomLottoNumbers = LottoNumbers(powerBall: powerBallNumber, nums: randonNums)
    let money = calculateWinning(randomLottoNumbers, pickedLottoNumbers)
    
    return LottoResult(numbers: randomLottoNumbers, dollars: money)
}

func calculateWinning(_ randomLottoNumbers: LottoNumbers,_ pickedLottoNumbers: LottoNumbers) -> Int {
    let powerPowerMatch = randomLottoNumbers.powerBall == pickedLottoNumbers.powerBall
    
    let numberOfMatchs = randomLottoNumbers.nums.filter {
        return pickedLottoNumbers.nums.contains($0)
    }.count
    
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
    
    guard let money = winningMatrix["\(powerPowerMatch)-\(numberOfMatchs)"] else {
        return 0
    }
    
    return money
}
