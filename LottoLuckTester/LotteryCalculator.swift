//
//  LotteryCalculator.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/16/21.
//

import Foundation

class LotteryCalculator {
    
    private let lottoNum1: Int
    private let lottoNum2: Int
    private let lottoNum3: Int
    private let lottoNum4: Int
    private let lottoNum5: Int
    private let powerNumber: Int

    
    init(num1: Int, num2: Int, num3: Int, num4: Int, num5: Int, powerNumber: Int) {
        self.lottoNum1 = num1
        self.lottoNum2 = num2
        self.lottoNum3 = num3
        self.lottoNum4 = num4
        self.lottoNum5 = num5
        self.powerNumber = powerNumber
    }
    
    func runLottery(result: LotteryResult) -> LotteryResult {
        let lottoPickedNums = Array(0...4).map {  _ in Int.random(in: 1..<71) }
        let powNum = Int.random(in: 1..<26)
        
        let didMatchPowerBall = powNum == self.powerNumber
        
        var ballCount = 0;
        
        if lottoPickedNums[0] == self.lottoNum1 {
            ballCount += 1
        }
        
        if lottoPickedNums[1] == self.lottoNum2 {
            ballCount += 1;
        }
        
        if lottoPickedNums[2] == self.lottoNum2 {
            ballCount += 1;
        }
        
        if lottoPickedNums[3] == self.lottoNum2 {
            ballCount += 1;
        }
        
                
        if didMatchPowerBall && ballCount == 0 {
            result.addToWinning("2")
        } else if didMatchPowerBall && ballCount == 1 {
             result.addToWinning("4")
        } else if didMatchPowerBall && ballCount == 2 {
             result.addToWinning("10")
        } else if didMatchPowerBall == false && ballCount == 3 {
             result.addToWinning("10")
        } else if didMatchPowerBall && ballCount == 3 {
             result.addToWinning("200")
        } else if didMatchPowerBall == false && ballCount == 4 {
            result.addToWinning("500")
        } else if didMatchPowerBall && ballCount == 4 {
            result.addToWinning("10000")
        } else if ballCount == 5 && didMatchPowerBall == false {
            result.addToWinning("1000000")
        } else if ballCount == 5 && didMatchPowerBall {
            result.addToWinning("jackpot")
        } else {
            result.addToLoss()
        }
        
        result.addToTimes()
        
        return result
    }
}

class LotteryResult {
    private var times = 0;
    private var losses = 0;
    private var winnings = ["2": 0, "4": 0, "10": 0, "200": 0, "500": 0, "10000": 0, "1000000": 0, "jackpot": 0]
    
    public func addToLoss() {
        self.losses += 1;
    }
    
    public func jackPots() -> Int {
        return self.winnings["jackpot"] ?? 0
    }
    
    public func addToTimes() {
        self.times += 1;
    }
    
    public func addToWinning(_ dollar: String) {
        var total = self.winnings[dollar] ?? 0
        total += 1
        self.winnings[dollar] = total
    }
    
    public func getLosses() -> Int {
        return self.losses
    }
    
    public func spent() -> Int {
        return self.times * 2
    }
    
    public func totalWinning() -> Int {
        
        var total = 0;
        
        for (key, times) in self.winnings {
            if key == "jackpot" {
                total += 100_000_000 * times
                continue
            }
            
            guard let addAmount = Int(key) else {
                print(key, "not working")
                continue;
            }
            total += addAmount * times
        }
        
        return total
    }
}
