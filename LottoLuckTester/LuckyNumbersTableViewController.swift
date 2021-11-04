//
//  LuckyNumbersTableViewController.swift
//  LottoLuckTester
//
//  Created by Noah Glaser on 10/28/21.
//

import UIKit

class LuckyNumbersTableViewController: UITableViewController {
    
    var rowHeight = 100

    var result: LotterySimulationResult = LotterySimulationResult(pickedLottoNumbers: LottoNumbers(powerBall: 32, nums: [2,3,3,4,5]))
    
    let evenColor = UIColor.init(red: 224.0 / 255, green: 140 / 255, blue: 40 / 255, alpha: 1)
    let oldColor = UIColor.orange

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.winningLottoResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "luckynumber", for: indexPath) as! WinningNumbersTableViewCell
        
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = evenColor
        } else {
            cell.backgroundColor = oldColor
        }
        
        let winningNumber: LottoResult = result.winningLottoResult[indexPath.row]
        
        
        cell.num1TextView.text = String(winningNumber.numbers.nums[0].0)
        cell.num2TextView.text = String(winningNumber.numbers.nums[1].0)
        cell.num3TextView.text = String(winningNumber.numbers.nums[2].0)
        cell.num4TextView.text = String(winningNumber.numbers.nums[3].0)
        cell.num5TextView.text = String(winningNumber.numbers.nums[4].0)
        cell.powerBallTextView.text = String(winningNumber.numbers.powerBall.0)
        cell.moneyLabel.text = winningNumber.dollars.toMoney()

        cell.textLabel?.text = ""

        highlightWinningNumber(cell.num1TextView, winningNumber.numbers.nums[0].1)
        highlightWinningNumber(cell.num2TextView, winningNumber.numbers.nums[1].1)
        highlightWinningNumber(cell.num3TextView, winningNumber.numbers.nums[2].1)
        highlightWinningNumber(cell.num4TextView, winningNumber.numbers.nums[3].1)
        highlightWinningNumber(cell.num5TextView, winningNumber.numbers.nums[4].1)
        highlightWinningNumber(cell.num5TextView, winningNumber.numbers.nums[4].1)
        highlightWinningNumber(cell.powerBallTextView, winningNumber.numbers.powerBall.1, true)

        return cell
    }
    
    func highlightWinningNumber(_ textView: UITextField, _ numberWon: Bool,_ isPowerBall: Bool = false) {
        if numberWon {
            textView.backgroundColor = .systemGreen
            textView.textColor = .white
        } else if isPowerBall {
            textView.backgroundColor = .black
            textView.textColor = .white
        } else {
            textView.backgroundColor = .white
            textView.textColor = .black
        }
    }

}
